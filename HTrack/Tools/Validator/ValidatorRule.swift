//
//  ValidatorRule.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/4/21.
//

import Foundation

enum ValidatorRule {
    case isNotEmpty
    case isEmail
    case isNickname
    case rule(regex: ValidatorRegex)
    
    var description: String {
        switch self {
        
        case .isNotEmpty:
            return "Обязательное поле"
        case .isEmail:
            return ValidatorRegex.email.description
        case .isNickname:
            return ValidatorRegex.nickname.description
        case .rule(let regex):
            return regex.description
        }
    }
    
    func validate(value: String?) -> Bool {
        guard let value = value else { return false }
        switch self {
        
        case .isNotEmpty:
            return validateISNotEmpty(value: value)
        case .isEmail:
            return checkRegEx(text: value, regEx: ValidatorRegex.email.regex)
        case .isNickname:
            return checkRegEx(text: value, regEx: ValidatorRegex.nickname.regex)
        case .rule(regex: let regex):
            return checkRegEx(text: value, regEx: regex.regex)
        }
    }
    
    private func validateISNotEmpty(value: String?) -> Bool {
        if let value = value,
           !value.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
    //MARK: checkRegEx
    private func checkRegEx(text: String, regEx: String) -> Bool {
        let textCheck  = NSPredicate(format:"SELF MATCHES %@", regEx)
        return textCheck.evaluate(with: text)
    }
}
