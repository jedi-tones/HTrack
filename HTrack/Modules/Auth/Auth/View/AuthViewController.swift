//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class AuthViewController: UIViewController {
    // MARK: Properties
    var output: AuthViewOutput!
    
    fileprivate var _stackviewCenterConstraint: NSLayoutConstraint?
    
    enum AuthViewControllerState {
        case notChecked
        case auth
        case register
        case load
    }
    
    fileprivate var _state: AuthViewControllerState = .notChecked
    fileprivate var buttonStartMaxY: CGFloat = .zero
    fileprivate var buttonWithPasswordStartMaxY: CGFloat = .zero
    
    fileprivate lazy var authTitle: UILabel = {
        let lb = UILabel()
        lb.text = "войди или зарегистрируйся"
        lb.font = Styles.Fonts.soyuz1
        lb.textColor = registraitionTitleColor
        lb.textAlignment = .center
        lb.isHidden = true
        return lb
    }()
    
    fileprivate lazy var emailInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("введи e-mail")
            .setKeyboardType(.emailAddress)
            .setRules([.isNotEmpty, .isEmail])
        
        tf.changeTextDelegate = {[weak self] _, _ in
            self?.setState(state: .notChecked, withError: nil)
            self?.nextButton.setStatus(.normal)
        }
        return tf
    }()
    
    fileprivate lazy var passwordInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("пароль")
            .setSecureText(true)
            .setRules([.isNotEmpty, .rule(regex: .password)])
        
        tf.alpha = 0
        tf.isHidden = true
        return tf
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Styles.Sizes.standartV2Inset
        sv.distribution = .equalSpacing
        return sv
    }()
    
    fileprivate lazy var nextButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: nextButtonColor)
            .setTitle(title: "продолжить")
            .setBorderColor(color: nil)
            .setTextColor(color: nextButtonTitleColor)
            .setStatus(.deactive)
        
        bt.action = { [weak self] in
            guard let self = self,
                  let email = self.emailInput.text else { return }
            
            switch self._state {
                
            case .notChecked:
                self.output.checkEmail(email: email)
            case .auth:
                guard let password = self.passwordInput.text else { return }
                self.output.authWithEmail(email: email, password: password)
            case .register:
                guard let password = self.passwordInput.text else { return }
                self.output.registerEmail(email: email, password: password)
            case .load:
                return
            }
        }
        return bt
    }()
    
    fileprivate lazy var keyboardNotification: KeyboardNotifications = {
        let kn = KeyboardNotifications(notifications: [.willShow, .didHide], delegate: self)
        return kn
    }()
    
    fileprivate var validator: Validator?

    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        buttonStartMaxY = nextButton.frame.maxY
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        keyboardNotification.isEnabled = false
    }
}

extension AuthViewController {
    // MARK: Methods
    fileprivate func setupViews() {
        validator = Validator(inputs: [emailInput, passwordInput], buttons: [nextButton])
        
        view.backgroundColor = backColor
        keyboardNotification.isEnabled = true
        setupConstraints()
    }

    fileprivate func setupConstraints() {
        view.addSubview(authTitle)
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailInput)
        stackView.addArrangedSubview(passwordInput)
        view.addSubview(nextButton)
        
        authTitle.edgesToSuperview(excluding: .bottom,
                                   insets: TinyEdgeInsets(top: Styles.Sizes.bigVInset,
                                                          left: Styles.Sizes.standartHInset,
                                                          bottom: .zero,
                                                          right: -Styles.Sizes.standartHInset),
                                   usingSafeArea: true)
        
        stackView.leftToSuperview(offset: Styles.Sizes.standartHInset)
        stackView.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        _stackviewCenterConstraint = stackView.centerYToSuperview()
        
        nextButton.leftToSuperview(offset: Styles.Sizes.standartHInset)
        nextButton.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        nextButton.topToBottom(of: stackView, offset: Styles.Sizes.standartV2Inset)
        nextButton.height(Styles.Sizes.baseButtonHeight)
    }
    
    fileprivate func updateLayoutToState(state: AuthViewControllerState) {
        switch state {
        
        case .notChecked:
            emailInput.isUserInteractionEnabled = true
            passwordInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
                self?.passwordInput.isHidden = true
                self?.passwordInput.alpha = 0
                self?.passwordInput.text = ""
            }
            nextButton.setTitle(title: "продолжить".uppercased(), animated: true)
            
        case .auth:
            emailInput.isUserInteractionEnabled = true
            passwordInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
                self?.passwordInput.setPlacehodler("пароль")
                self?.passwordInput.isHidden = false
                self?.passwordInput.alpha = 1
            } completion: { [weak self] _ in
                self?.buttonWithPasswordStartMaxY = self?.nextButton.frame.maxY ?? .zero
            }
            nextButton.setTitle(title: "войти", animated: true)
            
        case .register:
            emailInput.isUserInteractionEnabled = true
            passwordInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
                self?.passwordInput.setPlacehodler("Придумай пароль")
                self?.passwordInput.isHidden = false
                self?.passwordInput.alpha = 1
            } completion: { [weak self] _ in
                self?.buttonWithPasswordStartMaxY = self?.nextButton.frame.maxY ?? .zero
            }
            nextButton.setTitle(title: "зарегистрироваться".uppercased(), animated: true)
            
        case .load:
            emailInput.isUserInteractionEnabled = false
            passwordInput.isUserInteractionEnabled = false
            nextButton.setStatus(.busy)
        }
    }
    
    fileprivate func updateConstraints(keyboardY: CGFloat?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) stackview \(stackView.frame.maxY)")
        
        //keyboardWillShow вызывается 2 раза в случае если поле с ввода с паролем,
        //так как отрисовывается сама клава, потом бар над клавой для кейчейна.
        //что бы мы знали стартовую позицию кнопки во время второго вызова keyboardWillShow, запоминаем ее заранее
        var buttonMaxY: CGFloat = .zero
        switch _state {
            
        case .notChecked:
            buttonMaxY = buttonStartMaxY
        case .auth, .register, .load:
            buttonMaxY = buttonWithPasswordStartMaxY
        }
        
        if let keyboardY = keyboardY {
            if buttonMaxY  > keyboardY {
                let addY = (buttonMaxY - keyboardY) + Styles.Sizes.standartV2Inset
                _stackviewCenterConstraint?.constant = -addY
                UIView.animate(withDuration: Styles.Constants.animationDuarationBase) {[weak self] in
                    self?.view.layoutIfNeeded()
                }
            }
        } else {
            _stackviewCenterConstraint?.constant = 0
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) {[weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

// MARK: - AuthViewInput
extension AuthViewController: AuthViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
    
    func setState(state: AuthViewControllerState, withError: String?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        if let withError = withError {
            passwordInput.setError(withError)
        } else {
            passwordInput.removeError()
        }
        
        guard self._state != state else { return }
        _state = state
        updateLayoutToState(state: state)
    }
}

extension AuthViewController: KeyboardNotificationsDelegate {
    func keyboardWillShow(notification: NSNotification) {
        let keyboardInfo = KeyboardPayload(notification)
        
        guard keyboardInfo?.frameEnd.size.height ?? 0 > .zero else { return }
        if let keyboardY = keyboardInfo?.frameEnd.origin.y {
            updateConstraints(keyboardY: keyboardY)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        updateConstraints(keyboardY: nil)
    }
}

extension AuthViewController {
    fileprivate var backColor: UIColor {
        Styles.Colors.base1
    }
    
    fileprivate var registraitionTitleColor: UIColor {
        Styles.Colors.base3
    }
    
    fileprivate var nextButtonColor: UIColor {
        Styles.Colors.base3
    }
    
    fileprivate var nextButtonTitleColor: UIColor {
        Styles.Colors.base1
    }
}
