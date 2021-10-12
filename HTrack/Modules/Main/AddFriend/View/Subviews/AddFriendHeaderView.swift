//
//  AddFriendHeaderView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/3/21.
//

import UIKit
import TinyConstraints

class AddFriendHeaderView: UIView {
    enum AddFriendHeaderState {
        case normal
        case nicknameNotExist
        case load
    }
    
    private var state: AddFriendHeaderState = .normal
    var addFriendAction: ((_ nickname: String) -> Void)?
    
    lazy var addFriendInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("Никнейм друга")
            .setRules([.isNotEmpty, .isNickname])
        tf.changeTextDelegate = { [weak self] _, text in
            self?.updateState(to: .normal)
        }
        return tf
    }()
    
    lazy var addFriendButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: addButtonCollor)
            .setTitle(title: "Добавить")
            .setCornerRadius(radius: Styles.Sizes.baseCornerRadius)
            .setTextColor(color: addButtonTitleCollor)
        
        bt.action = { [weak self] in
            guard let nickname = self?.addFriendInput.text else { return }
            self?.addFriendAction?(nickname)
            self?.updateState(to: .load)
        }
        return bt
    }()
    
    fileprivate var validator: Validator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        validator = Validator(inputs: [addFriendInput], buttons: [addFriendButton])
    }
    
    private func setupConstraints() {
        addSubview(addFriendInput)
        addSubview(addFriendButton)
        
        addFriendInput.edgesToSuperview(excluding: .bottom,
                                        insets: UIEdgeInsets(top: Styles.Sizes.stadartVInset * 3,
                                                             left: Styles.Sizes.standartHInset,
                                                             bottom: .zero,
                                                             right: Styles.Sizes.standartHInset))
        addFriendButton.edgesToSuperview(excluding: .top,
                                         insets: UIEdgeInsets(top: .zero,
                                                              left: Styles.Sizes.standartHInset,
                                                              bottom: Styles.Sizes.stadartVInset * 3,
                                                              right: Styles.Sizes.standartHInset))
        addFriendButton.topToBottom(of: addFriendInput, offset: Styles.Sizes.stadartVInset * 3)
    }
    
    func updateState(to state: AddFriendHeaderState) {
        self.state = state
        
        switch state {
        case .normal:
            addFriendInput.isUserInteractionEnabled = true
            addFriendInput.error = ""
            addFriendButton.setStatus(.normal)
            
        case .nicknameNotExist:
            addFriendInput.isUserInteractionEnabled = true
            addFriendInput.error = "Пользователь с таким ником не найден"
            addFriendButton.setStatus(.deactive)
            
        case .load:
            addFriendInput.isUserInteractionEnabled = false
            addFriendInput.error = ""
            addFriendButton.setStatus(.busy)
        }
    }
}

extension AddFriendHeaderView {
    private func setupViewColor() {
        
    }
    
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    
    var niknameTitleColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    var addButtonCollor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    var addButtonTitleCollor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
}