//
//  BaseTextButtonWithArrow+Validator.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/4/21.
//

import Foundation

extension BaseTextButtonWithArrow: ValidatorButton {
    var validatorButtonDelegate: ValidatorButtonDelegate? {
        get {
            self._validatorButtonDelegate
        }
        set {
            self._validatorButtonDelegate = newValue
        }
    }
    
    func setStatus(_ status: BaseCustomButton.ButtonStatus) {
        setButtonStatus(status)
    }
}
