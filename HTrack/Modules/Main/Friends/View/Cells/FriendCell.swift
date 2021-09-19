//
//  FriendCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

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
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBig).font
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
        layer.cornerRadius = Styles.Sizes.smallCornerRadius
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.nameLabel.text = viewModel.name
            self?.countLabel.text = viewModel.count
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            
            countLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            countLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Styles.Sizes.standartHInset)
        ])
        
        let bottomConstraint = nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        
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
