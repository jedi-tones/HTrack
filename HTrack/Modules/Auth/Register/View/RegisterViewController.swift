//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

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
    
    lazy var nicknameTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Выбери никнейм"
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.textColor = niknameTitleColor
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var nicknameInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("Имя")
            .setRules([.isNotEmpty, .isNickname])
        tf.changeTextDelegate = { [weak self] _, text in
            self?.setupState(state: .notChecked)
        }
        return tf
    }()
    
    lazy var nextButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: nextButtonCollor)
            .setTitle(title: "Проверить")
            .setCornerRadius(radius: Styles.Sizes.baseCornerRadius)
            .setWithArrow(withArrow: true, arrowDirection: .right)
            .setTextColor(color: nextButtonTitleCollor)
        
        bt.action = { [weak self] in
            switch self?._state {
            
            case .notChecked:
                self?.checkNickname()
            case .nicknameNotExist:
                self?.saveNickname()
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

extension RegisterViewController {
    // MARK: Methods
    func setupViews() {
        validator = Validator(inputs: [nicknameInput], buttons: [nextButton])
        
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
        view.addSubview(nicknameTitle)
        view.addSubview(nicknameInput)
        view.addSubview(nextButton)
        
        nicknameTitle.translatesAutoresizingMaskIntoConstraints = false
        nicknameInput.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nicknameTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Styles.Sizes.bigVInset),
            nicknameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nicknameTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            
            nicknameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nicknameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Styles.Sizes.stadartVInset * 4),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            nextButton.heightAnchor.constraint(equalToConstant: Styles.Sizes.baseButtonHeight)
        ])
        
        nicknameInputCenterConstraint = nicknameInput.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        nicknameInputCenterConstraint?.isActive = true
    }
    
    fileprivate func updateLayoutToState(state: RegisterViewControllerState) {
        switch state {
        
        case .notChecked:
            nicknameInput.isUserInteractionEnabled = true
            nextButton.setStatus(.normal)
            nextButton.setTitle(title: "Проверить", animated: true)
            
        case .nicknameNotExist:
            nicknameInput.isUserInteractionEnabled = true
            nicknameInput.infoLabel = "Никнейм свободен"
            nextButton.setStatus(.normal)
            nextButton.setTitle(title: "Сохранить", animated: true)
            
        case .nicknameExist:
            nicknameInput.isUserInteractionEnabled = true
            nicknameInput.error = "Никнейм занят"
            nextButton.setStatus(.normal)
            nextButton.setTitle(title: "Проверить", animated: true)
            
        case .load:
            nicknameInput.isUserInteractionEnabled = false
            nextButton.setStatus(.busy)
        }
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

extension RegisterViewController {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    
    var niknameTitleColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    var nextButtonCollor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    var nextButtonTitleCollor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
}
