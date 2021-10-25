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
    
    lazy var detailButton: UIButtonWithHitTestInset = {
        let button = UIButtonWithHitTestInset(type: .custom)
        let hitInset: CGFloat = 12
        button.hitTestInset = UIEdgeInsets(top: hitInset, left: hitInset, bottom: hitInset, right: hitInset)
        button.setImage(Styles.Images.detailButton.withRenderingMode(.alwaysOriginal), for: .normal)
        button.startAction = { [weak self] in
            self?.viewModel?.tapInputRequestIcon()
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
        contentView.addSubview(detailButton)
        
        nameLabel.edgesToSuperview(excluding: .right,
                                   insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                          left: Styles.Sizes.standartHInset,
                                                          bottom: Styles.Sizes.standartHInset,
                                                          right: .zero))
        detailButton.centerYToSuperview()
        detailButton.height(Styles.Sizes.smallButtonHeight)
        detailButton.widthToHeight(of: detailButton)
        detailButton.rightToSuperview(offset: -Styles.Sizes.standartHInset)
        detailButton.leftToRight(of: nameLabel)
    }
}

extension RequestCell {
    var backColor: UIColor {
        .clear
    }
    
    var nameLabelColor: UIColor {
        Styles.Colors.base3
    }
}
