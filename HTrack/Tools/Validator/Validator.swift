//
//  Validator.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/3/21.
//

import Foundation

enum ValidatorResult {
    case valid
    case notValides(inputs:[ValidateInput])
}

protocol ValidateInput: AnyObject {
    var validatorInputDelegate: ValidatorInputDelegate? { get set }
    var rulesToValidate: [ValidatorRule] { get }
    var text: String? { get }
    var error: String? { get }
    var errors: [String] { get set }
    func setValidationError(_ error: String?)
    func removeValidationError()
}

protocol ValidatorButton: AnyObject {
    var validatorButtonDelegate: ValidatorButtonDelegate? { get set }
    func setStatus(_ status: BaseCustomButton.ButtonStatus)
}

protocol ValidatorButtonDelegate {
    func validate(button: ValidatorButton, complition:@escaping(ValidatorResult) -> Void)
}

protocol ValidatorInputDelegate {
    func inputChanged(input: ValidateInput)
}

class Validator {
    var inputs: [ValidateInput]
    var validatorButtons: [ValidatorButton]
    
    init(inputs:[ValidateInput], buttons: [ValidatorButton]) {
        self.inputs = inputs
        self.validatorButtons = buttons
        
        inputs.forEach({$0.validatorInputDelegate = self })
        buttons.forEach({$0.validatorButtonDelegate = self})
    }
    
    func validate(complition: @escaping(ValidatorResult) -> Void) {
        guard inputs.isNotEmpty else { return }
        
        for input in inputs {
            input.errors.removeAll()
            
            let rules = input.rulesToValidate
            for rule in rules {
                let validatedResult = rule.validate(value: input.text)
                if validatedResult.isNot() {
                    input.errors.append(rule.description)
                }
            }
            
            if let error = input.errors.first {
                input.setValidationError(error)
            } else {
                input.removeValidationError()
            }
        }
        
        let inputsWithErrors = inputs.filter({$0.errors.isNotEmpty})
        let hasErrors = inputsWithErrors.isNotEmpty
        
        if hasErrors {
            validatorButtons.forEach({$0.setStatus(.deactive)})
            complition(.notValides(inputs: inputsWithErrors))
        } else {
            validatorButtons.forEach({$0.setStatus(.normal)})
            complition(.valid)
        }
    }
}

extension Validator: ValidatorButtonDelegate {
    func validate(button: ValidatorButton, complition:@escaping(ValidatorResult) -> Void) {
        validate(complition: complition)
    }
}

extension Validator: ValidatorInputDelegate {
    func inputChanged(input: ValidateInput) {
        input.removeValidationError()
        
        validatorButtons.forEach({$0.setStatus(.normal)})
    }
}
