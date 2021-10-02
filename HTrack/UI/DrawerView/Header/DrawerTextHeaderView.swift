//
//  DrawerTextHeaderView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

class DrawerTextHeaderView: UIView {
    var onClose: (() -> Void)?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.baseNormalFont(size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButtonWithHitTestInset(type: .system)
        let hitInset: CGFloat = 12
        button.hitTestInset = UIEdgeInsets(top: hitInset, left: hitInset, bottom: hitInset, right: hitInset)
        button.setImage(Styles.Images.closeCross, for: .normal)
        button.addTarget(self, action: #selector(closeButtonAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    let containerView: UIView = UIView()
    let spacerView: UIView = UIView()
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: Styles.Sizes.mediumVInset,
                                            left: Styles.Sizes.mediumHInset * 2,
                                            bottom: Styles.Sizes.mediumVInset,
                                            right: Styles.Sizes.mediumHInset)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        containerView.edgesToSuperview(insets: insets)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(spacerView)
        containerView.addSubview(closeButton)
        
        titleLabel.edgesToSuperview(excluding: .right)
        closeButton.edgesToSuperview(excluding: .left)
        
        spacerView.topToSuperview()
        spacerView.bottomToSuperview()
        spacerView.leftToRight(of: titleLabel)
        spacerView.rightToLeft(of: closeButton)
        spacerView.width(Styles.Sizes.stadartVInset)
        
        updateViewColor()
    }
    
    var calculatedSize: CGSize {
        let height = max(titleLabel.intrinsicContentSize.height, closeButton.intrinsicContentSize.height) + insets.top + insets.bottom
        return CGSize(width: .infinity, height: height)
    }
    
    @objc private func closeButtonAction(sender: Any) {
        onClose?()
    }
}

extension DrawerTextHeaderView {
    func setTitle(title: String) {
        titleLabel.text = title
    }
}

extension DrawerTextHeaderView {
    func updateViewColor() {
        titleLabel.textColor = Styles.Colors.myLabelColor()
        closeButton.tintColor = Styles.Colors.myLabelColor()
    }
}
