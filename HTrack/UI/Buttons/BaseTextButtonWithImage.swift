//
//  BaseTextButtonWithImage.swift
//  HTrack
//
//  Created by Jedi Tones on 21.02.2022.
//

import UIKit

class BaseTextButtonWithImage: BaseCustomButton {
    enum ImagePosition {
        case left
        case right
    }
    
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = Styles.Fonts.bold2
        lb.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lb.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    private lazy var imageIcon: UIImageView = {
        let icon = UIImageView()
        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        icon.tintColor = textColor
        return icon
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Styles.Colors.base2
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private var buttonImage: UIImage?
    private var imagePosition: ImagePosition = .left
    private var kernValue: Double?
    
    private var insets: UIEdgeInsets = Styles.Sizes.baseButtonInsets
    private var rightStackConstraint: NSLayoutConstraint?
    private var buttonHeightConstraint: NSLayoutConstraint?
    
    private var buttonColor: UIColor? =  Styles.Colors.base1
    private var textColor: UIColor =  Styles.Colors.base2
    private var activityIndicatorColor =  Styles.Colors.base2
    private var borderColor: UIColor? = nil {
        didSet {
            if let borderColor = borderColor {
                layer.borderColor = borderColor.cgColor
                layer.borderWidth = Styles.Sizes.baseBorderWidth
            } else {
                layer.borderWidth = .zero
                layer.borderColor = nil
            }
        }
    }
    
    private var cornerRadius:CGFloat?  {
        didSet {
            setNeedsLayout()
        }
    }
    
    var _validatorButtonDelegate: ValidatorButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius ?? 0
    }
    
    override func startAction() {
        if let validator = _validatorButtonDelegate {
            validator.validate(button: self)
            { [weak self] result in
                switch result {
                
                case .valid:
                    self?.action?()
                case .notValides(inputs: _):
                    self?.setButtonStatus(.deactive)
                }
            }
        } else {
            action?()
        }
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = Styles.Sizes.baseHInset
        
        if let borderColor = borderColor {
            layer.borderWidth = Styles.Sizes.baseBorderWidth
            layer.borderColor = borderColor.cgColor
        } else {
            layer.borderWidth = .zero
            layer.borderColor = nil
        }
        
        setupConstraints()
        updateStackView()
    }
    
    private func updateStackView() {
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(titleLabel)
        
        if let buttonImage = buttonImage {
            switch imagePosition {
            
            case .left:
                let spacer1 = UIView()
                let spacer2 = UIView()
                
                imageIcon.image = buttonImage.withRenderingMode(.alwaysTemplate)
                stackView.insertArrangedSubview(spacer1, at: 0)
                stackView.insertArrangedSubview(imageIcon, at: 1)
                stackView.addArrangedSubview(spacer2)
                titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                spacer1.width(to: spacer2)
            case .right:
                imageIcon.image = buttonImage.withRenderingMode(.alwaysTemplate)
                stackView.insertArrangedSubview(UIView(), at: 0)
                stackView.addArrangedSubview(imageIcon)
                stackView.addArrangedSubview(UIView())
                titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            }
        }
    }
    
    private func setupConstraints() {
        self.addSubview(stackView)
        self.addSubview(activityIndicator)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        let topStackConstraint = stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top)
        topStackConstraint.priority = .defaultHigh
        topStackConstraint.isActive = true
        let bottomStackConstraint = stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
        bottomStackConstraint.priority = .defaultHigh
        bottomStackConstraint.isActive = true
        
        rightStackConstraint = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right)
        rightStackConstraint?.isActive = true
        
        buttonHeightConstraint = heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight)
        buttonHeightConstraint?.priority = .defaultHigh
        buttonHeightConstraint?.isActive = true
    }
    
    private func showActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            guard let self = self else { return }
            
            self.stackView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            self.layoutIfNeeded()
        }
    }
    
    private func hideActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            self?.stackView.isHidden = false
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            
            self?.layoutIfNeeded()
        }
    }
    
    @discardableResult
    override func setButtonStatus(_ status: ButtonStatus) -> Self {
        super.setButtonStatus(status)
        
        switch status {
        
        case .busy:
            showActivityIndicator()
            isUserInteractionEnabled = false
            
        case .normal:
            hideActivityIndicator()
            
//            titleLabel.textColor = textColor
//            arrowIcon.tintColor = textColor
            isUserInteractionEnabled = true
            
        case .deactive:
            hideActivityIndicator()
            
//            titleLabel.textColor = textColor.withAlphaComponent(0.3)
//            arrowIcon.tintColor = textColor.withAlphaComponent(0.3)
            isUserInteractionEnabled = false
        }
        return self
    }
}

extension BaseTextButtonWithImage {
    @discardableResult
    func setTitle(title: String?, animated: Bool = false) -> Self {
        
        if animated {
            titleLabel.swipeAndShow { [weak self] in
                self?.titleLabel.text = title
                
            } complition: {
                return
            }
        } else {
            titleLabel.text = title
           
        }
        return self
    }
    
    @discardableResult
    func setButtonColor(color: UIColor) -> Self {
        self.buttonColor = color
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    func setTextColor(color: UIColor) -> Self {
        self.textColor = color
        
        titleLabel.textColor = color
        activityIndicator.color = color
        
        return self
    }
    
    @discardableResult
    func setTitleFont(font: UIFont, kernValue: Double? = nil) -> Self {
        titleLabel.font = font
        self.kernValue = kernValue
        
        return self
    }
    
    @discardableResult
    func setWithImage(image: UIImage, imagePosition: ImagePosition) -> Self {
        self.buttonImage = image
        self.imagePosition = imagePosition
        updateStackView()
        
        return self
    }
    
    @discardableResult
    func setCornerRadius(radius: CGFloat) -> Self {
        self.cornerRadius = radius
        
        return self
    }
    
    @discardableResult
    func setBorderColor(color: UIColor?) -> Self {
        self.borderColor = color
        
        return self
    }
    
    @discardableResult
    func setHeight(height: CGFloat) -> Self {
        if height == .zero {
            self.buttonHeightConstraint?.isActive = false
        } else {
            self.buttonHeightConstraint?.isActive = true
            self.buttonHeightConstraint?.constant = height
        }
       
        
        return self
    }
}

extension BaseTextButtonWithImage: ValidatorButton {
    var validatorButtonDelegate: ValidatorButtonDelegate? {
        get {
            self._validatorButtonDelegate
        }
        set {
            self._validatorButtonDelegate = newValue
        }
    }
    
    func setStatus(_ status: ButtonStatus) {
        setButtonStatus(status)
    }
}
