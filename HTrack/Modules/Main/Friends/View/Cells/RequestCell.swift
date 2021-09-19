//
//  RequestCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

class RequestCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "requestCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = nameLabelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Name"
        return lb
    }()
    
    lazy var acceptButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "Принять")
            .setTitleFont(font: Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font)
            .setButtonColor(color: self.acceptButtonColor)
            .setTextColor(color: self.acceptButtonLabelColor)
        
        return bt
    }()
    
    lazy var cancelButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "Отклонить")
            .setTitleFont(font: Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font)
            .setButtonColor(color: self.cancelButtonColor)
            .setTextColor(color: self.cancelButtonLabelColor)
        
        return bt
    }()
    
    var viewModel: FriendInputRequestViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
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
            self?.nameLabel.text = viewModel.name
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(cancelButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Styles.Sizes.standartHInset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
            
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Styles.Sizes.standartHInset),
            acceptButton.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -Styles.Sizes.standartHInset),
            acceptButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Styles.Sizes.standartHInset)
        ])
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

extension RequestCell {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    
    var acceptButtonColor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    var acceptButtonLabelColor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
    
    var cancelButtonColor: UIColor {
        Styles.Colors.onlyTextButtonColor()
    }
    
    var cancelButtonLabelColor: UIColor {
        Styles.Colors.onlyTextButtonLabelColor()
    }
    
    var nameLabelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
