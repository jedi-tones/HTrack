//
//  WelcomeView.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit
import AuthenticationServices
import TinyConstraints

class WelcomeView: UIView {
    
    let containerView = UIView()
    let mainLogo: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Styles.Images.mainLogo
        return imageView
    }()
    lazy var signInWithApple: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "Войти с AppleID")
            .setTitleFont(font: Styles.Fonts.bold2)
            .setButtonColor(color: self.appleButtonColor)
            .setTextColor(color: self.appleButtonLabelColor)
            .setBorderColor(color: self.appleButtonLabelColor)
        
        return bt
    }()
    
    lazy var appleButton: ASAuthorizationAppleIDButton = {
        let bt = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        bt.cornerRadius = Styles.Sizes.baseCornerRadius
        return bt
    }()
    
    lazy var signInWithEmail: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "войду с e-mail")
            .setTitleFont(font: Styles.Fonts.soyuz1)
            .setButtonColor(color: self.emailButtonColor)
            .setTextColor(color: self.emailButtonLabelColor)
            .setBorderColor(color: nil)
        return bt
    }()
    
    lazy var orLabel: UILabel = {
        let lb = UILabel()
        lb.text = "ИЛИ"
        lb.font = Styles.Fonts.normal1
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
            .font: Styles.Fonts.normal0,
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
        addSubview(containerView)
        containerView.addSubview(mainLogo)
        addSubview(signInWithApple)
        addSubview(orLabel)
        addSubview(signInWithEmail)
        addSubview(privacyLabel)
        
        privacyLabel.edgesToSuperview(excluding: .top,
                                      insets: TinyEdgeInsets(top: .zero,
                                                             left: Styles.Sizes.baseHInset,
                                                             bottom: Styles.Sizes.stadartVInset,
                                                             right: Styles.Sizes.baseHInset),
                                      usingSafeArea: true)
        privacyLabel.height(100)
        
        signInWithEmail.bottomToTop(of: privacyLabel, offset: -Styles.Sizes.stadartVInset)
        signInWithEmail.centerX(to: self)
        
        orLabel.bottomToTop(of: signInWithEmail, offset: -Styles.Sizes.stadartVInset)
        orLabel.centerX(to: self)
        
        signInWithApple.bottomToTop(of: orLabel, offset: -Styles.Sizes.stadartVInset)
        signInWithApple.leftToSuperview(offset: Styles.Sizes.standartHInset)
        signInWithApple.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        signInWithApple.height(Styles.Sizes.appleButtonHeight)
        
        containerView.edgesToSuperview(excluding: .bottom)
        containerView.bottomToTop(of: signInWithApple)
        
        mainLogo.centerInSuperview()
    }
}

extension WelcomeView {
    var backColor: UIColor {
        Styles.Colors.base1
    }
    
    var appleButtonColor: UIColor {
        Styles.Colors.base1
    }
    
    var appleButtonLabelColor: UIColor {
        Styles.Colors.base3
    }
    
    var emailButtonColor: UIColor {
        Styles.Colors.base1
    }
    
    var emailButtonLabelColor: UIColor {
        Styles.Colors.base3
    }
    
    var privacyLabelColor: UIColor {
        Styles.Colors.base3.withAlphaComponent(0.5)
    }
    
    var privacyLinkColor: UIColor {
        Styles.Colors.base3
    }
}
