//
//  RequestCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit
import TinyConstraints

class RequestCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "requestCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = nameLabelColor
        lb.font = Styles.Fonts.bold2
        lb.text = "Name"
        return lb
    }()
    
    lazy var rejectButton: UIButtonWithHitTestInset = {
        let button = UIButtonWithHitTestInset(type: .custom)
        let hitInset: CGFloat = 12
        button.hitTestInset = UIEdgeInsets(top: hitInset, left: hitInset, bottom: hitInset, right: hitInset)
        button.setImage(Styles.Images.closeCross.withRenderingMode(.alwaysOriginal), for: .normal)
        button.startAction = { [weak self] in
            self?.viewModel?.tapRejectIcon()
        }
        return button
    }()
    
    lazy var acceptButton: UIButtonWithHitTestInset = {
        let button = UIButtonWithHitTestInset(type: .custom)
        let hitInset: CGFloat = 12
        button.hitTestInset = UIEdgeInsets(top: hitInset, left: hitInset, bottom: hitInset, right: hitInset)
        button.setImage(Styles.Images.plusButton.withRenderingMode(.alwaysOriginal), for: .normal)
        button.startAction = { [weak self] in
            self?.viewModel?.tapAcceptIcon()
        }
        return button
    }()
    
    var viewModel: FriendInputRequestViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? FriendInputRequestViewModel else { return }
        
        self.viewModel = viewModel
        
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.nameLabel.text = "@\(viewModel.name.uppercased())"
        }
    }
    
    private func setupView() {
        backgroundColor = backColor
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(rejectButton)
        
        nameLabel.edgesToSuperview(excluding: .right,
                                   insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                          left: Styles.Sizes.standartHInset,
                                                          bottom: Styles.Sizes.standartHInset,
                                                          right: .zero))
        rejectButton.centerYToSuperview()
        rejectButton.height(Styles.Sizes.smallButtonHeight)
        rejectButton.widthToHeight(of: rejectButton)
        rejectButton.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        rejectButton.leftToRight(of: nameLabel)
        
        acceptButton.centerYToSuperview()
        acceptButton.height(Styles.Sizes.smallButtonHeight)
        acceptButton.widthToHeight(of: acceptButton)
        acceptButton.rightToLeft(of: rejectButton, offset: -Styles.Sizes.standartHInset)
        acceptButton.leftToRight(of: nameLabel)
    }
}

extension RequestCell {
    var backColor: UIColor {
        let friendsColorsDaysOffset = Styles.Constants.friendsColorsDaysOffset
        return Styles.Colors.progressedColor(days: friendsColorsDaysOffset)
    }
    
    var nameLabelColor: UIColor {
        Styles.Colors.base3
    }
}
