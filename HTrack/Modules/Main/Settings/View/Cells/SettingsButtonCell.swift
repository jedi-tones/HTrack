//
//  SettingsButtonCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import UIKit

class SettingsButtonCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "textCollectionCell"
    }
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Кнопка"
        return lb
    }()
    
    var needAnimationTap = true
    
    var viewModel: SettingsButtonViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? SettingsButtonViewModel else { return }
        
        self.viewModel = viewModel
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        backgroundColor = Styles.Colors.mySecondBackgroundColor()
        layer.cornerRadius = Styles.Sizes.baseCornerRadius
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Styles.Sizes.standartHInset),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
        ])
    }
}
