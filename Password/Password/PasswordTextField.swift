//
//  PasswordTextField.swift
//  Password
//
//  Created by Ebpearls on 08/06/2022.
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
}

class PasswordTextField: UIView, UITextFieldDelegate {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText: String
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
    weak var delegate: PasswordTextFieldDelegate? //To avoid the retain cycle we are making the delegate weak.

    init(placeHolderText2: String) {
        self.placeHolderText = placeHolderText2
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    //Initializing the placeHolderText constant variable so that we do not need to hard code the text and reuse it later.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Giving the view its height and weight. Here the view is PasswordTextField.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - <LockImageView>
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - <TextField>
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable //.asciiCapable keyboard type disables user to enter emojis
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                             attributes: [NSAttributedString
                                                                            .Key
                                                                            .foregroundColor: UIColor
                                                                            .secondaryLabel]) //Giving the attributes to the placeholed text
        // extra interaction
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        //MARK: - <eyeButton>
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        //MARK: - <dividerView>
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        //MARK: - <errorLabel>
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        //        errorLabel.text = "Enter your Password"
        errorLabel.text = "Your password must meet the requirements below."
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = UIColor.systemRed
        //        errorLabel.adjustsFontSizeToFitWidth = true //Reduces the font size to adjust the text in the allocated space.
        //        errorLabel.minimumScaleFactor = 0.8 //Reduce the font size only up to 80%. Not more than 80%.
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
        
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        //MARK: - <LockImageView>
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        //MARK: - <TextField>
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
        ])
        
        //MARK: - <eyeButton>
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        //MARK: - <dividerView>
        dividerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //MARK: - <errorLabel>
        errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //MARK: - <Content-Hugging-Compression-Resistance>
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
    }
}

extension PasswordTextField {
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self) //send back the text and the viewController receives it through the delegate
    }
}

