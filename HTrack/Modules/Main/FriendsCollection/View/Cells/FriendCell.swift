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
        lb.textColor = labelColor(days: 0)
        lb.font = Styles.Fonts.bold2
        lb.text = "Name"
        return lb
    }()
    
    lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor(days: 0)
        lb.font = Styles.Fonts.normal1
        lb.text = "0 Дней"
        return lb
    }()
    
    var imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = Styles.Colors.base1
        iv.setCornerRadius(radius: Styles.Sizes.baseAvatarHeight / 2)
        return iv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = .zero
        sv.distribution = .fill
        sv.alignment = .leading
        return sv
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? FriendViewModel else { return }
        
        self.viewModel = viewModel
        
        setup()
    }
    
    func setupView() {
        backgroundColor = backColor
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            let friendsColorsDaysOffset = Styles.Constants.friendsColorsDaysOffset
            let daysCount = viewModel.daysCount + friendsColorsDaysOffset
            
            self?.nameLabel.text = "@\(viewModel.name.uppercased())"
            self?.countLabel.text = viewModel.count
            self?.nameLabel.textColor = self?.labelColor(days: daysCount)
            self?.countLabel.textColor = self?.labelColor(days: daysCount)
            self?.backgroundColor = Styles.Colors.progressedColor(days: daysCount)
            if viewModel.daysCount < 2 {
                self?.imageView.layer.borderWidth = Styles.Sizes.baseBorderWidth
                self?.imageView.layer.borderColor = Styles.Colors.base3.withAlphaComponent(0.1).cgColor
            } else {
                self?.imageView.layer.borderWidth = .zero
                self?.imageView.layer.borderColor = nil
            }
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(countLabel)
        
//        imageView.edgesToSuperview(excluding: .right,
//                                   insets: TinyEdgeInsets(top: Styles.Sizes.stadartVInset,
//                                                          left: Styles.Sizes.standartHInset,
//                                                          bottom: Styles.Sizes.stadartVInset,
//                                                          right: Styles.Sizes.standartHInset),
//                                   priority: .defaultHigh)
//        imageView.height(Styles.Sizes.baseAvatarHeight)
//        imageView.widthToHeight(of: imageView)
        stackView.edgesToSuperview(insets: TinyEdgeInsets(top: Styles.Sizes.stadartVInset * 2,
                                                          left: Styles.Sizes.standartHInset,
                                                          bottom: Styles.Sizes.stadartVInset * 2,
                                                          right: Styles.Sizes.standartHInset))
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        countLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

extension FriendCell {
    var backColor: UIColor {
        .clear
    }
    
    func labelColor(days: Int) -> UIColor {
        Styles.Colors.progressedOverlayColor(days: days)
    }
}
