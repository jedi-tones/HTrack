//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class RegisterViewController: UIViewController {
    // MARK: Properties
    var output: RegisterViewOutput!
    
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
        let tv = TextFieldWithError()
            .setPlacehodler("Имя")
            .setRules([.isNotEmpty, .isNickname])
        return tv
    }()
    
    lazy var nextButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: nextButtonCollor)
            .setTitle(title: "Cохранить")
            .setCornerRadius(radius: Styles.Sizes.baseCornerRadius)
            .setWithArrow(withArrow: true, arrowDirection: .right)
            .setTextColor(color: nextButtonTitleCollor)
        
        bt.action = { [weak self] in
            self?.output.saveNickname()
        }
        return bt
    }()
    
     var validator: Validator?

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
        
        view.backgroundColor = backColor
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(nicknameTitle)
        view.addSubview(nicknameInput)
        view.addSubview(nextButton)
        
        nicknameTitle.translatesAutoresizingMaskIntoConstraints = false
        nicknameInput.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nicknameTitle.bottomAnchor.constraint(equalTo: nicknameInput.topAnchor, constant: -Styles.Sizes.bigVInset),
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
}

// MARK: - RegisterViewInput
extension RegisterViewController: RegisterViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
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
