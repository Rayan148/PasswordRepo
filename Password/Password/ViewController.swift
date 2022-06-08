//
//  ViewController.swift
//  Password
//
//  Created by Ebpearls on 08/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText2: "New Password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        
        //MARK: - <newPasswordTextField>
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - <stackView>
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = .yellow
    }
    
    func layout() {
//        view.addSubview(newPasswordTextField)
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        
//        NSLayoutConstraint.activate([
//            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextField.trailingAnchor, multiplier: 1),
//            newPasswordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
//            newPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
//            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

