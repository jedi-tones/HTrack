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
    
    ///ValidateInput
    var _validatorInputDelegate: ValidatorInputDelegate?
    var _rulesToValidate: [ValidatorRule] = []
    var _errors: [String] = []
    
    var changeTextDelegate: ((TextFieldWithError, String?) -> Void)?
    var returnAction: ((TextFieldWithError)-> Void)?
    var beginEditingAction: ((TextFieldWithError)-> Void)?
    var endEditingAction: ((TextFieldWithError)-> Void)?
    
    lazy var textField: TextFieldWithInsets = {
        let tf = TextFieldWithInsets()
        tf.borderStyle = .none
        tf.font = Styles.Fonts.bold2
        tf.layer.cornerRadius = self.needCorners ? Styles.Sizes.baseCornerRadius : .zero
        tf.layer.borderWidth = Styles.Sizes.baseBorderWidth
        return tf
    }()
    
    lazy var customPlaceholder: UILabel = {
        let lb = UILabel()
        lb.font = Styles.Fonts.soyuz1
        lb.textColor = placeholderColor
        lb.text = "Placeholder"
        return lb
    }()
    
    lazy var errorLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Error"
        lb.font = Styles.Fonts.normal0
        lb.textColor = errorLabelColor
        lb.isHidden = true
        lb.alpha = 0
        lb.numberOfLines = 2
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
    
    var maxStringLength: Int = 20
    var limitMaxLength: Bool = false
    var needCorners: Bool = false
    
    var _placeholderColor: UIColor?
    var _borderColor: UIColor?
    var _textfieldTextColor: UIColor?
    var _errorLabelColor: UIColor?
    var _infoLabelColor: UIColor?
    
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
            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: Styles.Sizes.baseTextFieldLeftInset),
            errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -Styles.Sizes.baseTextFieldLeftInset)
        ])
        
        topPlaceholderConstraint = customPlaceholder.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -Styles.Sizes.baseVInset)
        topPlaceholderConstraint?.isActive = false
        
        centerPlaceholderConstraint = customPlaceholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        centerPlaceholderConstraint?.isActive = true
    }
    
     func updatePlaceholder() {
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
    
    func updateBorder() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            guard let self = self else { return }
            self.textField.layer.borderColor = self.borderColor.cgColor
            self.layoutIfNeeded()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let topSize = customPlaceholder.sizeThatFits(size)
        let inputSize = textField.sizeThatFits(size)
        let bootomSize = errorLabel.sizeThatFits(size)
        
        let width = max(inputSize.width, size.width)
        var height = (topSize.height == 0) ? 0 : topSize.height + Styles.Sizes.baseVInset
        height += inputSize.height
        height += (bootomSize.height == 0) ? 0 : bootomSize.height + Styles.Sizes.baseVInset
        
        return CGSize(width: width, height: height)
    }
}

extension TextFieldWithError {
    var placeholderColor: UIColor {
        switch textFieldState {
        
        case .active:
            return _placeholderColor ?? Styles.Colors.base3
        case .inActive:
            if isEmpty {
                return _placeholderColor?.withAlphaComponent(0.5) ?? Styles.Colors.base3.withAlphaComponent(0.5)
            } else {
                return _placeholderColor ?? Styles.Colors.base3
            }
        }
    }
    
    var borderColor: UIColor {
        switch textFieldState {
        
        case .active:
            return _borderColor ?? Styles.Colors.base3
        case .inActive:
            if isEmpty {
                return _borderColor?.withAlphaComponent(0.5) ?? Styles.Colors.base3.withAlphaComponent(0.5)
            } else {
                return _borderColor ?? Styles.Colors.base3
            }
        }
    }
    
    var textfieldTextColor: UIColor {
        return _textfieldTextColor ?? Styles.Colors.base3
    }
    
    var errorLabelColor: UIColor {
        return _errorLabelColor ?? Styles.Colors.base3
    }
    
    var infoLabelColor: UIColor {
        return _infoLabelColor ?? Styles.Colors.base3
    }
}

extension TextFieldWithError {
    override func becomeFirstResponder() -> Bool {
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        textField.isUserInteractionEnabled = false
        textField.resignFirstResponder()
        
        return super.resignFirstResponder()
    }
    
    override func endEditing(_ force: Bool) -> Bool {
        textField.endEditing(force)
        textField.isUserInteractionEnabled = false
        
        return super.endEditing(force)
    }
}
