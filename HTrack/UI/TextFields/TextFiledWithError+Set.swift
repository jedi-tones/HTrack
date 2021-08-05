//
//  TextFiledWithError+Set.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/3/21.
//

import UIKit

extension TextFieldWithError {
    
    @discardableResult
    func setMaxStringLength(_ length: Int?) -> Self {
        if let length = length {
            if length == 0 {
                limitMaxLength = false
                maxStringLength = 0
            } else {
                limitMaxLength = true
                maxStringLength = length
            }
        } else {
            limitMaxLength = false
            maxStringLength = 0
        }
        return self
    }
    
    @discardableResult
    func setPlacehodler(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func setError(_ error: String?) -> Self {
        self.error = error
        return self
    }
    
    @discardableResult
    func removeError() -> Self {
        self.error = nil
        return self
    }
    
    @discardableResult
    func setRules(_ rules: [ValidatorRule]) -> Self {
        self._rulesToValidate = rules
        return self
    }
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType ) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func setSecureText(_ isSecureText: Bool ) -> Self {
        self.secureTextEntry = isSecureText
        return self
    }
}

