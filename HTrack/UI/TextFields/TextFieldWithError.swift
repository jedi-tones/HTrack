//
//  TextFieldWithError.swift
//  HTrack
//
//  Created by Jedi Tones on 8/3/21.
//

import UIKit

class TextFieldWithError: UIView {
    
    private var topPlaceholderConstraint: NSLayoutConstraint?
    private var centerPlaceholderConstraint: NSLayoutConstraint?
    
    enum TextFieldState {
        case active
        case inActive
    }
    
    let textField: TextFieldWithInsets = {
        let tf = TextFieldWithInsets()
        tf.borderStyle = .none
        tf.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        tf.layer.cornerRadius = Styles.Sizes.baseCornerRadius
        tf.layer.borderWidth = Styles.Sizes.baseBorderWidth
        return tf
    }()
    
    lazy var customPlaceholder: UILabel = {
        let lb = UILabel()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.textColor = placeholderColor
        lb.text = "Placeholder"
        return lb
    }()
    
    lazy var errorLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Error"
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeSmall).font
        lb.textColor = errorLabelColor
        return lb
    }()
    
    var textFieldState: TextFieldState = .inActive {
        didSet {
            updatePlaceholder()
            updateBorder()
        }
    }
    
    var isEmpty: Bool {
        textField.text?.isEmpty ?? true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        textField.textColor = textfieldTextColor
        textField.tintColor = textfieldTextColor
        textField.delegate = self
        
        updateBorder()
        updatePlaceholder()
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(textField)
        addSubview(customPlaceholder)
        addSubview(errorLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        customPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: Styles.Sizes.stadartVInset),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Styles.Sizes.stadartVInset),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight),
            
            customPlaceholder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: Styles.Sizes.baseTextFieldLeftInset),
            
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Styles.Sizes.baseVInset),
            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: Styles.Sizes.baseTextFieldLeftInset)
        ])
        
        topPlaceholderConstraint = customPlaceholder.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -Styles.Sizes.baseVInset)
        topPlaceholderConstraint?.isActive = false
        
        centerPlaceholderConstraint = customPlaceholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        centerPlaceholderConstraint?.isActive = true
    }
    
    private func updatePlaceholder() {
        switch self.textFieldState {
        case .active:
            self.centerPlaceholderConstraint?.isActive = false
            self.topPlaceholderConstraint?.isActive = true
        case .inActive:
            if self.isEmpty {
                self.topPlaceholderConstraint?.isActive = false
                self.centerPlaceholderConstraint?.isActive = true
            } else {
                self.centerPlaceholderConstraint?.isActive = false
                self.topPlaceholderConstraint?.isActive = true
            }
        }
        
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            guard let self = self else { return }
            self.customPlaceholder.textColor = self.placeholderColor
            self.layoutIfNeeded()
        }
    }
    
    private func updateBorder() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            guard let self = self else { return }
            self.textField.layer.borderColor = self.borderColor.cgColor
            self.layoutIfNeeded()
        }
    }
}

extension TextFieldWithError {
    var placeholderColor: UIColor {
        switch textFieldState {
        
        case .active:
            return Styles.Colors.myLabelColor()
        case .inActive:
            if isEmpty {
                return Styles.Colors.myPlaceholderColor()
            } else {
                return Styles.Colors.myLabelColor()
            }
        }
    }
    
    var borderColor: UIColor {
        switch textFieldState {
        
        case .active:
            return Styles.Colors.myLabelColor()
        case .inActive:
            if isEmpty {
                return Styles.Colors.myPlaceholderColor()
            } else {
                return Styles.Colors.myLabelColor()
            }
        }
    }
    
    var textfieldTextColor: UIColor {
        return Styles.Colors.myLabelColor()
    }
    
    var errorLabelColor: UIColor {
        return Styles.Colors.myErrorLabelColor()
    }
}

extension TextFieldWithError: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldState = .active
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldState = .inActive
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
