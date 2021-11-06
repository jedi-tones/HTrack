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
        case error(error: String)
        case load
    }
    
    private var state: AddFriendHeaderState = .normal
    var addFriendAction: ((_ nickname: String) -> Void)?
    
    lazy var addFriendInput: TextFieldWithError = {
        let tf = TextFieldWithError()
            .setPlacehodler("никнейм друга")
            .setRules([.isNotEmpty, .isNickname])
        tf.changeTextDelegate = { [weak self] _, text in
            self?.updateState(to: .normal)
        }
        return tf
    }()
    
    lazy var addFriendButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setButtonColor(color: addButtonCollor)
            .setTitle(title: "отправить запрос")
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
                                        insets: UIEdgeInsets(top: Styles.Sizes.stadartVInset,
                                                             left: Styles.Sizes.standartHInset,
                                                             bottom: .zero,
                                                             right: Styles.Sizes.standartHInset))
        addFriendButton.edgesToSuperview(excluding: .top,
                                         insets: UIEdgeInsets(top: .zero,
                                                              left: Styles.Sizes.standartHInset,
                                                              bottom: Styles.Sizes.stadartVInset,
                                                              right: Styles.Sizes.standartHInset))
        addFriendButton.topToBottom(of: addFriendInput, offset: Styles.Sizes.standartV2Inset)
    }
    
    func updateState(to state: AddFriendHeaderState) {
        self.state = state
        
        switch state {
        case .normal:
            addFriendInput.isUserInteractionEnabled = true
            addFriendInput.error = ""
            addFriendButton.setStatus(.normal)
            
        case .error(let error):
            addFriendInput.isUserInteractionEnabled = true
            addFriendInput.error = error
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
        Styles.Colors.base1
    }
    
    var niknameTitleColor: UIColor {
        Styles.Colors.base3
    }
    
    var addButtonCollor: UIColor {
        Styles.Colors.base3
    }
    
    var addButtonTitleCollor: UIColor {
        Styles.Colors.base1
    }
}
