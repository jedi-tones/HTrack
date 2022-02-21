//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class RegisterViewController: UIViewController {
    // MARK: Properties
    var output: RegisterViewOutput!
    
    enum RegisterViewControllerState {
        case notChecked
        case nicknameExist
        case nicknameNotExist
        case load
    }
    
    fileprivate var _state: RegisterViewControllerState = .notChecked
    var nicknameInputCenterConstraint: NSLayoutConstraint?
    
    lazy var nicknameInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("никнейм")
            .setRules([.isNotEmpty, .isNickname])
        tf.changeTextDelegate = { [weak self] _, text in
            if self?._state != .notChecked {
                self?.setupState(state: .notChecked)
            }
        }
        tf.endEditingAction = {[weak self] textField in
            let oldText = textField.text
            textField.text = self?.getFormattedNickname(text: oldText)
        }
        return tf
    }()
    
    lazy var nextButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: nextButtonCollor)
            .setTitle(title: LocDic.sharedContinue)
            .setTextColor(color: nextButtonTitleCollor)
        
        bt.action = { [weak self] in
            switch self?._state {
            
            case .notChecked:
                self?.checkNickname()
            case .nicknameNotExist:
                self?.checkNickname()
            case .nicknameExist:
                self?.checkNickname()
            case .load:
                return
            case .none:
                break
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

extension RegisterViewController {
    // MARK: Methods
    func setupViews() {
        validator = Validator(inputs: [nicknameInput], buttons: [nextButton])
        
        keyboardNotification.isEnabled = true
        configureNavigationBar()
        view.backgroundColor = backColor
        setupConstraints()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    func checkNickname() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.checkNickName(name: nicknameInput.text ?? "")
    }
    
    func saveNickname() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.saveNickname(name: nicknameInput.text ?? "")
    }

    func setupConstraints() {
        view.addSubview(nicknameInput)
        view.addSubview(nextButton)
        
        nicknameInput.leftToSuperview(offset: Styles.Sizes.standartHInset)
        nicknameInput.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        nicknameInputCenterConstraint = nicknameInput.centerYToSuperview()
        
        nextButton.left(to: nicknameInput)
        nextButton.right(to: nicknameInput)
        nextButton.topToBottom(of: nicknameInput, offset: Styles.Sizes.standartV2Inset)
    }
    
    fileprivate func getFormattedNickname(text: String?) -> String? {
        text?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").uppercased()
    }
    
    fileprivate func updateLayoutToState(state: RegisterViewControllerState) {
        switch state {
        
        case .notChecked:
            nicknameInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            
        case .nicknameNotExist:
            nicknameInput.isUserInteractionEnabled = true
            nicknameInput.infoLabel = "Никнейм свободен"
            nextButton.setStatus(.normal)
            
        case .nicknameExist:
            nicknameInput.isUserInteractionEnabled = true
            nicknameInput.error = "Никнейм занят"
            nextButton.setStatus(.normal)
            
        case .load:
            nicknameInput.isUserInteractionEnabled = false
            nextButton.setStatus(.busy)
        }
    }
    
    fileprivate func updateConstraints(keyboardY: CGFloat?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        if let keyboardY = keyboardY {
            if nextButton.frame.maxY  > keyboardY {
                let addY = (nextButton.frame.maxY - keyboardY) + Styles.Sizes.standartV2Inset
                nicknameInputCenterConstraint?.constant = -addY
                UIView.animate(withDuration: Styles.Constants.animationDuarationBase) {[weak self] in
                    self?.view.layoutIfNeeded()
                }
            }
        } else {
            nicknameInputCenterConstraint?.constant = 0
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

// MARK: - RegisterViewInput
extension RegisterViewController: RegisterViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
    
    func setupState(state: RegisterViewControllerState) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) state: \(state)")
        
        _state = state
        updateLayoutToState(state: state)
    }
}

extension RegisterViewController: KeyboardNotificationsDelegate {
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

extension RegisterViewController {
    var backColor: UIColor {
        Styles.Colors.base1
    }
    
    var nextButtonCollor: UIColor {
        Styles.Colors.base3
    }
    
    var nextButtonTitleCollor: UIColor {
        Styles.Colors.base1
    }
}
