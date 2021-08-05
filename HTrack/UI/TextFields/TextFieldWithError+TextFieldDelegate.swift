//
//  TextFieldWithError+TextFieldDelegate.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/3/21.
//

import UIKit

extension TextFieldWithError: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldState = .active
        
        beginEditingAction?(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldState = .inActive
        
        validate()
        endEditingAction?(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnAction?(self)
        
        return textField.resignFirstResponder()
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        willUpdateText(text: textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        func updText() -> String {
            guard let tx = textField.text, let txRange = Range(range, in: tx) else { return "" }

            let updText = tx.replacingCharacters(in: txRange, with: string)
            return updText
        }

        let updatedText = updText()
        
        if limitMaxLength {
            if updatedText.count <= maxStringLength {
                willUpdateText(text: updatedText)
                return true
            } else {
                return false
            }
        } else {
            willUpdateText(text: updatedText)
            return true
        }
    }
    
    fileprivate func willUpdateText(text: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) text \(text)")
        changeTextDelegate?(self, text)
        
        if text.count == 0 {
//            hideCloseIcon()
        } else {
//            showCloseIcon()
        }
        
        
        ///do somthing in validator
        if let validatorInputDelegate = _validatorInputDelegate {
            ///error was delete in validator
            validatorInputDelegate.inputChanged(input: self)
        } else {
            ///simple delete error
            removeError()
        }
        
        
    }
    
    fileprivate func validate() {
      
    }
}
