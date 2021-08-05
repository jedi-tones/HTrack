//
//  BaseTextButton.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

class BaseTextButtonWithArrow: BaseCustomButton {
    enum ArrowDirection {
        case left
        case right
    }
    
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lb.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lb
    }()
    private lazy var arrowIcon: UIImageView = {
        let icon = UIImageView()
        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        icon.tintColor = textColor
        return icon
    }()
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Styles.Colors.myActivityIndicatorColor()
        return view
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    private var withArrow = false
    private var arrowDirection: ArrowDirection = .left
    
    private var insets: UIEdgeInsets = Styles.Sizes.baseButtonInsets
    private var rightStackConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var buttonColor: UIColor = Styles.Colors.myFilledButtonColor()
    private var textColor: UIColor = Styles.Colors.myFilledButtonLabelColor()
    private var activityIndicatorColor = Styles.Colors.myActivityIndicatorColor()
    
    private var cornerRadius:CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var _validatorButtonDelegate: ValidatorButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius ?? frame.height / 2
    }
    
    override func startAction() {
        _validatorButtonDelegate?.validate(button: self)
        { [weak self] result in
            switch result {
            
            case .valid:
                self?.action?()
            case .notValides(inputs: _):
                return
            }
        }
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = Styles.Sizes.baseHInset
        
        setupConstraints()
        updateStackView()
    }
    
    private func updateStackView() {
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(titleLabel)
        
        if withArrow {
            switch arrowDirection {
            
            case .left:
                titleLabel.textAlignment = .left
                arrowIcon.image = Styles.Images.buttonLeftArrow.withRenderingMode(.alwaysTemplate)
                stackView.insertArrangedSubview(arrowIcon, at: 0)
            case .right:
                titleLabel.textAlignment = .left
                arrowIcon.image = Styles.Images.buttonRightArrow.withRenderingMode(.alwaysTemplate)
                stackView.addArrangedSubview(arrowIcon)
            }
        } else {
            titleLabel.textAlignment = .center
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
        
        heightConstraint = heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight)
        heightConstraint?.priority = .defaultHigh
        heightConstraint?.isActive = true
    }
    
    private func showActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            guard let self = self else { return }
            
            self.titleLabel.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            self.layoutIfNeeded()
        }
    }
    
    private func hideActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
            self?.titleLabel.isHidden = false
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
        case .normal:
            hideActivityIndicator()
            
            titleLabel.textColor = textColor
            arrowIcon.tintColor = textColor
            isUserInteractionEnabled = true
            
        case .deactive:
            hideActivityIndicator()
            
            titleLabel.textColor = textColor.withAlphaComponent(0.3)
            arrowIcon.tintColor = textColor.withAlphaComponent(0.3)
            isUserInteractionEnabled = false
        }
        return self
    }
}

extension BaseTextButtonWithArrow {
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
        arrowIcon.tintColor = color
        
        return self
    }
    
    @discardableResult
    func setTitleFont(font: UIFont) -> Self {
        titleLabel.font = font
        
        return self
    }
    
    @discardableResult
    func setWithArrow(withArrow: Bool, arrowDirection: ArrowDirection) -> Self {
        self.withArrow = withArrow
        self.arrowDirection = arrowDirection
        updateStackView()
        
        return self
    }
    
    @discardableResult
    func setCornerRadius(radius: CGFloat) -> Self {
        self.cornerRadius = radius
        
        return self
    }
    
    @discardableResult
    func setHeight(height: CGFloat) -> Self {
        self.heightConstraint?.constant = height
        
        return self
    }
}
