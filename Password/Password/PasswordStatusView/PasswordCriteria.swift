//
//  PasswordCriteria.swift
//  Password
//
//  Created by Ebpearls on 09/06/2022.
//

import UIKit

struct PasswordCriteria {
    static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    static func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
        
    static func lengthAndNoSpaceMet(_ text: String) -> Bool { //To change the color of the image.
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    static func uppercaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    static func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }

    static func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    static func specialCriteriaMet(_ text: String) -> Bool {
        // regex escaped @:?!()$#,.\/
        text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil //the '\' is escaped here using three '\' infront of it.
    }
}
