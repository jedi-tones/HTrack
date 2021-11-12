//
//  AddFriendContentView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

class DetailContentView: UIScrollView, ScrollableContent {
    var scrollViewDelegate: UIScrollViewDelegate?
    var didChangeContentSize: ((_ size: CGSize) -> ())?
    
    private var keyboardHeight: CGFloat = 0
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: false)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "contentSize")
    }
    
    var viewModel: FriendDetailViewModel?
    var requestViewModel: FriendRequestViewModel?
    
    var viewBlocks: [UIView] = []
    
    lazy var mainStackView: UIStackView = {
        let insets = UIEdgeInsets(top: Styles.Sizes.stadartVInset,
                                  left: Styles.Sizes.standartHInset,
                                  bottom: Styles.Sizes.stadartVInset,
                                  right: Styles.Sizes.standartHInset)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = Styles.Sizes.standartV2Inset
        stackView.width(Styles.Sizes.screenSize.width - insets.left - insets.right)
        addSubview(stackView)
        stackView.edgesToSuperview(insets: insets)
        return stackView
    }()
    
    //MARK: Friends detail
    lazy var title: UILabel = {
        let t = UILabel()
        t.text = "дней без алкоголя"
        t.font = Styles.Fonts.soyuz1
        t.textColor = titleColor
        t.textAlignment = .center
        return t
    }()
    
    lazy var counter: UILabel = {
        let c = UILabel()
        c.text = "0"
        c.textColor = counterColor
        c.adjustsFontSizeToFitWidth = true
        c.minimumScaleFactor = 0.2
        c.font = Styles.Fonts.soyuz3
        c.textAlignment = .center
        return c
    }()
    
    lazy var reactionButton: BaseTextButtonWithArrow = {
        let button = BaseTextButtonWithArrow()
        button.setTitle(title: "подбордить друга")
        button.setTextColor(color: self.reactionButtonTextColor)
        button.setButtonColor(color: self.reactionButtonColor)
        button.action = {[weak self] in
            self?.viewModel?.tapReactionButton()
        }
        return button
    }()
    
    lazy var removeButton: BaseTextButtonWithArrow = {
        let button = BaseTextButtonWithArrow()
        button.setTitle(title: "удалить")
        button.setTextColor(color: self.removeButtonTextColor)
        button.setButtonColor(color: self.removeButtonBackColor)
        button.setBorderColor(color: self.removeButtonColor)
        button.action = {[weak self] in
            self?.viewModel?.tapRemoveButton()
        }
        return button
    }()
    
    //MARK: Friends input request detail
    lazy var inputRequestName: UILabel = {
        let t = UILabel()
        t.text = "nickname"
        t.font = Styles.Fonts.bold3
        t.textColor = requestNameColor
        t.textAlignment = .center
        return t
    }()
    
    lazy var acceptButton: BaseTextButtonWithArrow = {
        let button = BaseTextButtonWithArrow()
        button.setTitle(title: "принять")
        button.setTextColor(color: self.acceptButtonTextColor)
        button.setButtonColor(color: self.acceptButtonBackColor)
        button.setBorderColor(color: self.acceptButtonColor)
        button.action = {[weak self] in
            self?.requestViewModel?.tapAcceptButton()
        }
        return button
    }()
    
    lazy var rejectButton: BaseTextButtonWithArrow = {
        let button = BaseTextButtonWithArrow()
        button.setTitle(title: "отклонить")
        button.setTextColor(color: self.rejectButtonTextColor)
        button.setButtonColor(color: self.rejectButtonBackColor)
        button.setBorderColor(color: self.rejectButtonColor)
        button.action = {[weak self] in
            self?.requestViewModel?.tapRejectButton()
        }
        return button
    }()
    
    //friend detail
    func setData(_ data: FriendDetailViewModel) {
        self.viewBlocks.removeAll()
        self.viewModel = data
        
        data.viewBlocks.forEach { (viewBlock) in
            switch viewBlock {
            case .title(title: let title):
                self.title.text = title
                self.viewBlocks.append(self.title)
                
            case .counter(count: let count):
                self.counter.text = String(count)
                self.viewBlocks.append(self.counter)
                
            case .friendReactionButton(title: let title):
                self.reactionButton.setTitle(title: title)
                self.viewBlocks.append(self.reactionButton)
                
            case .removeButton(title: let title):
                self.removeButton.setTitle(title: title)
                self.viewBlocks.append(self.removeButton)
                
            }
        }
        setupViews()
    }
    
    //input request detail
    func setData(_ data: FriendRequestViewModel) {
        self.viewBlocks.removeAll()
        self.requestViewModel = data
        
        data.viewBlocks.forEach { (viewBlock) in
            switch viewBlock {
            case .name(title: let title):
                self.inputRequestName.text = title
                self.viewBlocks.append(self.inputRequestName)
                
            case .acceptButton(title: let title):
                self.acceptButton.setTitle(title: title)
                self.viewBlocks.append(self.acceptButton)
                
            case .rejectButton(title: let title):
                self.rejectButton.setTitle(title: title)
                self.viewBlocks.append(self.rejectButton)
            }
        }
        setupViews()
    }
    
    func setupViews() {
        addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        mainStackView.removeAllArrangedSubviews()
        
        viewBlocks.forEach { view in
            mainStackView.addArrangedSubview(view)
        }
        
        mainStackView.setCustomSpacing(Styles.Sizes.stadartVInset, after: acceptButton)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIScrollView {
            if obj == self && keyPath == "contentSize" {
                didChangeContentSize?(obj.contentSize)
            }
        }
    }
}

extension DetailContentView {
    var titleColor: UIColor {
        Styles.Colors.base3
    }
    
    var counterColor: UIColor {
        Styles.Colors.base3
    }
    
    var reactionButtonColor: UIColor {
        Styles.Colors.base3
    }
    
    var reactionButtonTextColor: UIColor {
        Styles.Colors.base1
    }
    
    var removeButtonColor: UIColor {
        Styles.Colors.base3
    }
    
    var removeButtonTextColor: UIColor {
        Styles.Colors.base3
    }
    
    var removeButtonBackColor: UIColor {
        .clear
    }
    
    //request detail
    var requestNameColor: UIColor {
        Styles.Colors.base3
    }
    
    var acceptButtonColor: UIColor {
        Styles.Colors.base3
    }
    
    var acceptButtonTextColor: UIColor {
        Styles.Colors.base3
    }
    
    var acceptButtonBackColor: UIColor {
        .clear
    }
    
    var rejectButtonColor: UIColor {
        Styles.Colors.base3
    }
    
    var rejectButtonTextColor: UIColor {
        Styles.Colors.base3
    }
    
    var rejectButtonBackColor: UIColor {
        .clear
    }
}

extension DetailContentView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}
