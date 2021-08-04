//
//  Validator.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/3/21.
//

import Foundation

enum ValidatorResult {
    case valid
    case notValides(rules:[ValidatorRule])
}

class Validator {
    var rulesToValidate: [ValidatorRule] = []
    var notValid: [ValidatorRule] = []
    
    init(rules: [ValidatorRule]) {
        rulesToValidate = rules
    }
    
    func isValid(value: String?, complition: @escaping (ValidatorResult) -> Void ) {
        clear()
        
        for rule in rulesToValidate {
            let validatedResult = rule.validate(value: value)
            if validatedResult.isNot() {
                notValid.append(rule)
            }
        }
        
        if notValid.isNotEmpty {
            complition(.notValides(rules: notValid))
        } else {
            complition(.valid)
        }
    }
    
    func clear() {
        notValid = []
    }
}
