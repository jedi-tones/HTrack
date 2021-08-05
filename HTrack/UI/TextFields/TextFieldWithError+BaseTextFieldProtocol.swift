//
//  TextFieldWithError+BaseTextFieldProtocol.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/3/21.
//

import UIKit

protocol BaseTextFieldProtocol {
    var text: String? { get set }
    var placeholder: String? { get set }
    var error: String? { get set }
    var secureTextEntry: Bool { get set }
    var textContentType: UITextContentType { get set }
    var keyboardType: UIKeyboardType { get set }
    var returnKeyType: UIReturnKeyType { get set }
}

extension TextFieldWithError: BaseTextFieldProtocol {
    var text: String? {
        get { return textField.text }
        set {
            textField.text = newValue
            updatePlaceholder()
            updateBorder()
            removeError()
            changeTextDelegate?(self, newValue)
        }
    }
    
    var placeholder: String? {
        get { return customPlaceholder.text }
        set { customPlaceholder.text = newValue }
    }
    
    var error: String? {
        get { return errorLabel.text }
        set {
            errorLabel.text = newValue
            errorLabel.isHidden = newValue == nil
        }
    }
    
    var secureTextEntry: Bool {
        get { return textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }
    
    var textContentType: UITextContentType {
        get { return textField.textContentType }
        set { textField.textContentType = newValue}
    }
    
    var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue}
    }
    
    var returnKeyType: UIReturnKeyType {
        get { return textField.returnKeyType }
        set { textField.returnKeyType = newValue}
    }
}
