//
//  FriendCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit
import TinyConstraints

class FriendCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "friendCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBig).font
        lb.text = "Name"
        return lb
    }()
    
    lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextRegular(size: Styles.Sizes.fontSizeMedium).font
        lb.text = "0 Дней"
        return lb
    }()
    
    var viewModel: FriendViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? FriendViewModel else { return }
        
        self.viewModel = viewModel
        
        setup()
    }
    
    func setupView() {
        backgroundColor = backColor
        layer.cornerRadius = Styles.Sizes.baseCornerRadius
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.nameLabel.text = "@\(viewModel.name.uppercased())"
            self?.countLabel.text = viewModel.count
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        
        nameLabel.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                                              left: Styles.Sizes.standartHInset,
                                                                              bottom: .zero,
                                                                              right: Styles.Sizes.standartHInset))
        countLabel.edgesToSuperview(excluding: [.top, .bottom], insets: TinyEdgeInsets(top: .zero,
                                                                               left: Styles.Sizes.standartHInset,
                                                                               bottom: Styles.Sizes.standartHInset,
                                                                               right: Styles.Sizes.standartHInset))
        countLabel.topToBottom(of: nameLabel)
        countLabel.bottomToSuperview(offset: -Styles.Sizes.stadartVInset, priority: .defaultHigh)
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

extension FriendCell {
    var backColor: UIColor {
        Styles.Colors.mySecondBackgroundColor()
    }
    
    var labelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
