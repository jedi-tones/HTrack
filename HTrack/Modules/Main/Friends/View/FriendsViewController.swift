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
            .setTitle(title: LocDic.friendsAdd)
            .setTextColor(color: addButtonTitleCollor)
        
        bt.action = { [weak self] in
            self?.output.addFriendButtonTapped()
        }
        return bt
    }()
    
    lazy var vertStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = Styles.Sizes.standartV2Inset
        stack.axis = .vertical
        return stack
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
        view.addSubview(screenToggle)
        view.addSubview(vertStackView)
        vertStackView.addArrangedSubview(addFriendButton)
        //контейнер для View сабмодулей
        vertStackView.addArrangedSubview(containerView)
        
        screenToggle.topToSuperview(offset: Styles.Sizes.stadartVInset * 2, usingSafeArea: true)
        screenToggle.leadingToSuperview(offset: Styles.Sizes.standartHInset)
        screenToggle.trailingToSuperview(offset: Styles.Sizes.standartHInset)
        screenToggle.height(Styles.Sizes.baseButtonHeight)
        
        vertStackView.topToBottom(of: screenToggle, offset: Styles.Sizes.standartV2Inset)
        vertStackView.edgesToSuperview(excluding: .top,
                                       insets: TinyEdgeInsets(top: .zero,
                                                              left: Styles.Sizes.standartHInset,
                                                              bottom: .zero,
                                                              right: Styles.Sizes.standartHInset),
                                       usingSafeArea: true)
    
        addFriendButton.height(Styles.Sizes.baseButtonHeight)
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
    
    func setAddButton(isHidden: Bool) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) isHidden: \(isHidden)")
        
        addFriendButton.isHidden = isHidden
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
