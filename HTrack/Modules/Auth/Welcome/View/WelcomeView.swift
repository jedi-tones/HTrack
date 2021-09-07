//
//  WelcomeView.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit
import AuthenticationServices

class WelcomeView: UIView {
    
    let logoImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var signInWithApple: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "Войти с AppleID")
            .setTitleFont(font: Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font)
            .setButtonColor(color: self.appleButtonColor)
            .setTextColor(color: self.appleButtonLabelColor)
            .setWithArrow(withArrow: false, arrowDirection: .right)
        
        return bt
    }()
    
    lazy var appleButton: ASAuthorizationAppleIDButton = {
        let bt = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        bt.cornerRadius = Styles.Sizes.baseCornerRadius
        return bt
    }()
    
    lazy var signInWithEmail: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "Войти с Email")
            .setTitleFont(font: Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font)
            .setButtonColor(color: self.emailButtonColor)
            .setTextColor(color: self.emailButtonLabelColor)
        return bt
    }()
    
    lazy var orLabel: UILabel = {
        let lb = UILabel()
        lb.text = "ИЛИ"
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeMedium).font
        lb.textColor = Styles.Colors.mySecondaryLabelColor()
        return lb
    }()
    
    let privacyLabel: UITextView = {
        let lb = UITextView()
        lb.contentMode = .center
        lb.backgroundColor = .clear
        return lb
    }()
    
    lazy var linkTextFormatter = LinkTextFormatter(textColor: self.privacyLinkColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = backColor
        setupConstraints()
        setupPrivacyLabel()
    }
    
    private func setupPrivacyLabel() {
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let termsAndConditionsText = "условиями и положениями"
        let privacyPolicyText = "политикой конфиденциальности"
        let fullString = "Выполняя вход, ты соглашаешься с нашими \n \(termsAndConditionsText) \n и \n \(privacyPolicyText)"
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: privacyLabelColor,
            .font: Styles.Fonts.AvenirFonts.AvenirNextUltraLight(size: Styles.Sizes.fontSizeSmall).font,
            .paragraphStyle: paragraphStyle,
        ]
        let attributedString = NSMutableAttributedString(string: fullString, attributes: attributes)
        
        var links: [LinkTextFormatter.Link] = []
        
        if let termsURL = URL(string: "https://flava.app/terms/"),
           let privacyURL = URL(string: "https://flava.app/privacy/") {
            let termsLink = LinkTextFormatter.Link(text: termsAndConditionsText,
                                                   url: termsURL)
            let privacyLink = LinkTextFormatter.Link(text: privacyPolicyText,
                                                     url: privacyURL)
            links.append(termsLink)
            links.append(privacyLink)
        }
       
        let attributedTextWithLinks = linkTextFormatter.attributedText(attributedString: attributedString,
                                                                       links: links)
        privacyLabel.linkTextAttributes = [.foregroundColor : privacyLinkColor]
        privacyLabel.attributedText = attributedTextWithLinks
    }
    
    private func setupConstraints() {
        addSubview(logoImage)
        addSubview(signInWithApple)
        addSubview(orLabel)
        addSubview(signInWithEmail)
        addSubview(privacyLabel)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        signInWithApple.translatesAutoresizingMaskIntoConstraints = false
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        signInWithEmail.translatesAutoresizingMaskIntoConstraints = false
        privacyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Styles.Sizes.baseVInset),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Styles.Sizes.baseHInset),
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Styles.Sizes.baseHInset),
            
            privacyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
            privacyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Styles.Sizes.baseHInset),
            privacyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Styles.Sizes.baseHInset),
            privacyLabel.heightAnchor.constraint(equalToConstant: 100),
            
            signInWithEmail.bottomAnchor.constraint(equalTo: privacyLabel.topAnchor, constant: -Styles.Sizes.stadartVInset),
            signInWithEmail.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            orLabel.bottomAnchor.constraint(equalTo: signInWithEmail.topAnchor, constant: -Styles.Sizes.stadartVInset),
            orLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signInWithApple.bottomAnchor.constraint(equalTo: orLabel.topAnchor, constant: -Styles.Sizes.stadartVInset),
            signInWithApple.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Styles.Sizes.standartHInset),
            signInWithApple.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Styles.Sizes.standartHInset),
            signInWithApple.heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight)
        ])
        
        let logoImageBottomConstraint = logoImage.bottomAnchor.constraint(equalTo: signInWithApple.topAnchor, constant: -Styles.Sizes.baseInterItemInset)
        logoImageBottomConstraint.isActive = true
    }
}

extension WelcomeView {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    
    var appleButtonColor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    var appleButtonLabelColor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
    
    var emailButtonColor: UIColor {
        Styles.Colors.onlyTextButtonColor()
    }
    
    var emailButtonLabelColor: UIColor {
        Styles.Colors.onlyTextButtonLabelColor()
    }
    
    var privacyLabelColor: UIColor {
        Styles.Colors.mySecondaryLabelColor()
    }
    
    var privacyLinkColor: UIColor {
        Styles.Colors.myLabelLinkColor()
    }
}
