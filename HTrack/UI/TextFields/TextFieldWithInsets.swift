//
//  TextFieledWithInsets.swift
//  HTrack
//
//  Created by Jedi Tones on 8/3/21.
//

import UIKit

class TextFieldWithInsets: UITextField {
    var insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                            left: Styles.Sizes.baseTextFieldLeftInset,
                                            bottom: 0,
                                            right: Styles.Sizes.baseTextFieldRightInset)
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: insets)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        return rect.inset(by: insets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: insets)
    }
    
    
}
