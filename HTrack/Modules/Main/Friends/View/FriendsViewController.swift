//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class FriendsViewController: ContainerViewContoller {
    // MARK: Properties
    var output: FriendsViewOutput!
    
    lazy var rightSettingsButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Styles.Images.settingButtonImage,
                                   style: .plain,
                                   target: self,
                                   action: #selector(settingsButtonTapped(sender:)))
        return item
    }()
    
    lazy var screenToggle: ButtonToggle = {
        let toggle = ButtonToggle()
        toggle.buttonToggleDelegate = self
        return toggle
    }()
    
    lazy var addFriendButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: addButtonCollor)
            .setTitle(title: "добавить друга")
            .setTextColor(color: addButtonTitleCollor)
        
        bt.action = { [weak self] in
            self?.output.addFriendButtonTapped()
        }
        return bt
    }()
    
    var customNavView = FriendsCustomNavigationView()
    
    lazy var leftNavButton: UIBarButtonItem = {
        let item = UIBarButtonItem(customView: customNavView)
        return item
    }()
    
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
    
    @objc private func settingsButtonTapped(sender: UIBarButtonItem) {
        output.settingsButtonTapped()
    }
}

extension FriendsViewController {
    // MARK: Methods
    func setupViews() {
        view.backgroundColor = backColor
        navigationItem.backButtonTitle = ""
        setupNavBar()
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(addFriendButton)
        view.addSubview(screenToggle)
        //контейнер для View сабмодулей
        view.addSubview(containerView)
        
        screenToggle.topToSuperview(offset: Styles.Sizes.stadartVInset * 2, usingSafeArea: true)
        screenToggle.leadingToSuperview(offset: Styles.Sizes.standartHInset)
        screenToggle.trailingToSuperview(offset: Styles.Sizes.standartHInset)
        screenToggle.height(Styles.Sizes.baseButtonHeight)
        
        addFriendButton.topToBottom(of: screenToggle, offset: Styles.Sizes.standartV2Inset)
        addFriendButton.leadingToSuperview(offset: Styles.Sizes.standartHInset)
        addFriendButton.trailingToSuperview(offset: Styles.Sizes.standartHInset)
        addFriendButton.height(Styles.Sizes.baseButtonHeight)
        
        containerView.topToBottom(of: addFriendButton, offset: Styles.Sizes.standartV2Inset)
        containerView.edgesToSuperview(excluding: .top, usingSafeArea: true)
    }
}

// MARK: - FriendsViewInput
extension FriendsViewController: FriendsViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
    
    func updateNickname(nickName: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        DispatchQueue.main.async {[weak self] in
            self?.customNavView.updateTitle(title: nickName)
        }
    }
    
    func setPages(_ pages: [FriendsPage]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let titles = pages.map({$0.title})
        screenToggle.setButtonTitles(buttonTitles: titles)
    }
    
    func selectPage(page: FriendsPage) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        screenToggle.setIndex(index: page.index)
        transitionToSubmodule(page: page)
    }
}

extension FriendsViewController: ButtonToggleDelegate {
    func changeToIndex(index: Int) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) index: \(index)")
        
        output.screenToggleChangeToIndex(index)
    }
}

extension FriendsViewController {
    var backColor: UIColor {
        Styles.Colors.base1
    }
    
    var addButtonCollor: UIColor {
        Styles.Colors.base3
    }
    
    var addButtonTitleCollor: UIColor {
        Styles.Colors.base1
    }
}
