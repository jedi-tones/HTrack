//
//  TextFieldWithError+ValidateInput.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/4/21.
//

import UIKit

extension TextFieldWithError: ValidateInput {
    var needValidate: Bool {
        isHidden.isNot()
    }
    
    var validatorInputDelegate: ValidatorInputDelegate? {
        get {
            _validatorInputDelegate
        }
        set {
            _validatorInputDelegate = newValue
        }
    }
    
    var rulesToValidate: [ValidatorRule] {
        _rulesToValidate
    }
    
    var errors: [String] {
        get {
            _errors
        }
        set {
            _errors = newValue
        }
    }
    
    func setValidationError(_ error: String?) {
        setError(error)
    }
    
    func removeValidationError() {
        removeError()
    }
}
