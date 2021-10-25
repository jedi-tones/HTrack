//
//  OutputFriendRequestCell.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

class OutputFriendRequestCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "outputFriendRequestCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBig).font
        lb.text = "Name"
        return lb
    }()
    
    lazy var closeButton: UIButtonWithHitTestInset = {
        let button = UIButtonWithHitTestInset(type: .custom)
        let hitInset: CGFloat = 12
        button.hitTestInset = UIEdgeInsets(top: hitInset, left: hitInset, bottom: hitInset, right: hitInset)
        button.setImage(Styles.Images.closeCross.withRenderingMode(.alwaysOriginal), for: .normal)
        button.startAction = { [weak self] in
            self?.viewModel?.tapCancel()
        }
        return button
    }()
    
    var viewModel: FriendOutputRequestViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? FriendOutputRequestViewModel else { return }
        
        self.viewModel = viewModel
        
        setup()
    }
    
    func setupView() {
        backgroundColor = backColor
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.nameLabel.text = "@\(viewModel.name.uppercased())"
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(closeButton)
        
        nameLabel.edgesToSuperview(excluding: .right, insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                                             left: Styles.Sizes.mediumHInset,
                                                                             bottom: Styles.Sizes.standartHInset,
                                                                             right: .zero))
        closeButton.edgesToSuperview(excluding: .left, insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                                              left: .zero,
                                                                              bottom: Styles.Sizes.standartHInset,
                                                                              right: Styles.Sizes.mediumHInset))
        closeButton.height(Styles.Sizes.smallButtonHeight)
        closeButton.widthToHeight(of: closeButton)
        nameLabel.rightToLeft(of: closeButton,offset: Styles.Sizes.standartHInset, relation: .equalOrLess)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        //contentView.height(Styles.Sizes.baseButtonHeight, relation: .equalOrGreater)
    }
}

extension OutputFriendRequestCell {
    var backColor: UIColor {
        .clear
    }
    
    var labelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
    
    var closeButtonColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
