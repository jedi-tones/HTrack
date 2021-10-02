//
//  AddFriendContentView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

class FriendDetailContentView: UIScrollView, ScrollableContent {
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
    var viewBlocks: [UIView] = []
    
    lazy var mainStackView: UIStackView = {
        let insets = UIEdgeInsets(top: Styles.Sizes.stadartVInset,
                                  left: Styles.Sizes.standartHInset,
                                  bottom: Styles.Sizes.stadartVInset,
                                  right: Styles.Sizes.standartHInset)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = .zero
        stackView.setCustomSpacing(Styles.Sizes.stadartVInset, after: counter)
        stackView.width(Styles.Sizes.screenSize.width - insets.left - insets.right)
        addSubview(stackView)
        stackView.edgesToSuperview(insets: insets)
        return stackView
    }()
    
    lazy var title: UILabel = {
        let t = UILabel()
        t.text = "Friend"
        t.font = Styles.Fonts.baseBoldFont(size: 17)
        t.textColor = titleColor
        t.textAlignment = .center
        return t
    }()
    
    lazy var counter: UILabel = {
        let c = UILabel()
        c.text = "0"
        c.textColor = counterColor
        c.font = Styles.Fonts.baseBoldFont(size: 144)
        c.textAlignment = .center
        return c
    }()
    
    lazy var removeButton: BaseTextButtonWithArrow = {
        let button = BaseTextButtonWithArrow()
        button.setTitle(title: "Удалить")
        button.setTextColor(color: self.removeButtonTextColor)
        button.setButtonColor(color: self.removeButtonBackColor)
        button.setBorderColor(color: self.removeButtonColor)
        button.action = {[weak self] in
            self?.viewModel?.tapRemoveButton()
        }
        return button
    }()
    
    func setData(_ data: FriendDetailViewModel) {
        self.viewModel = data
        
        data.viewBlocks.forEach { (viewBlock) in
            switch viewBlock {
            case .title(title: let title):
                self.title.text = title
                self.viewBlocks.append(self.title)
                
            case .counter(count: let count):
                self.counter.text = String(count)
                self.viewBlocks.append(self.counter)
                
            case .removeButton(title: let title):
                self.removeButton.setTitle(title: title)
                self.viewBlocks.append(self.removeButton)
                
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
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIScrollView {
            if obj == self && keyPath == "contentSize" {
                didChangeContentSize?(obj.contentSize)
            }
        }
    }
}

extension FriendDetailContentView {
    var titleColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    var counterColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    var removeButtonColor: UIColor {
        Styles.Colors.myErrorLabelColor()
    }
    
    var removeButtonTextColor: UIColor {
        Styles.Colors.myErrorLabelColor()
    }
    
    var removeButtonBackColor: UIColor {
        .clear
    }
}

extension FriendDetailContentView: UIScrollViewDelegate {
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
