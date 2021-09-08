//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

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
    
    fileprivate lazy var authTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Войди или зарегистрируйся"
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.textColor = registraitionTitleColor
        lb.textAlignment = .center
        return lb
    }()
    
    fileprivate lazy var emailInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("Email")
            .setKeyboardType(.emailAddress)
            .setRules([.isNotEmpty, .isEmail])
        
        tf.changeTextDelegate = {[weak self] _, _ in
            self?.setState(state: .notChecked)
            self?.nextButton.setStatus(.normal)
        }
        return tf
    }()
    
    fileprivate lazy var passwordInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("Пароль")
            .setSecureText(true)
            .setRules([.isNotEmpty, .rule(regex: .password)])
        
        tf.alpha = 0
        tf.isHidden = true
        return tf
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Styles.Sizes.stadartVInset * 4
        sv.distribution = .equalSpacing
        return sv
    }()
    
    fileprivate lazy var keyboardNotification: KeyboardNotifications = {
        let kn = KeyboardNotifications(notifications: [.didShow, .didHide], delegate: self)
        return kn
    }()
    
    fileprivate lazy var nextButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: nextButtonColor)
            .setTitle(title: "Проверить")
            .setCornerRadius(radius: Styles.Sizes.baseCornerRadius)
            .setWithArrow(withArrow: true, arrowDirection: .right)
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
        
        authTitle.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Styles.Sizes.bigVInset),
            authTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            authTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Styles.Sizes.stadartVInset * 4),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            nextButton.heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight)
        ])
        
        _stackviewCenterConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        _stackviewCenterConstraint?.isActive = true
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
            nextButton.setTitle(title: "Проверить", animated: true)
            
        case .auth:
            emailInput.isUserInteractionEnabled = true
            passwordInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
                self?.passwordInput.setPlacehodler("Пароль")
                self?.passwordInput.isHidden = false
                self?.passwordInput.alpha = 1
            }
            nextButton.setTitle(title: "Войти", animated: true)
            
        case .register:
            emailInput.isUserInteractionEnabled = true
            passwordInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) { [weak self] in
                self?.passwordInput.setPlacehodler("Придумай пароль")
                self?.passwordInput.isHidden = false
                self?.passwordInput.alpha = 1
            }
            nextButton.setTitle(title: "Зарегистрироваться", animated: true)
            
        case .load:
            emailInput.isUserInteractionEnabled = false
            passwordInput.isUserInteractionEnabled = false
            nextButton.setStatus(.busy)
        }
    }
    
    fileprivate func updateConstraints(keyboardY: CGFloat?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) stackview \(stackView.frame.maxY)")
        
        if let keyboardY = keyboardY {
            if stackView.frame.maxY  > keyboardY {
                let addY = stackView.frame.maxY - keyboardY
                _stackviewCenterConstraint?.constant = addY
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
    
    func setState(state: AuthViewControllerState) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard self._state != state else { return }
        _state = state
        updateLayoutToState(state: state)
    }
}

extension AuthViewController: KeyboardNotificationsDelegate {
    func keyboardDidShow(notification: NSNotification) {
        let keyboardInfo = KeyboardPayload(notification)
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
        Styles.Colors.myBackgroundColor()
    }
    
    fileprivate var registraitionTitleColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    fileprivate var nextButtonColor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    fileprivate var nextButtonTitleColor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
}
