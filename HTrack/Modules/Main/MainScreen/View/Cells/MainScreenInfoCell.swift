//
//  MainScreenInfoCell.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

class MainScreenInfoCell: UICollectionViewCell, BaseCell {
    static var reuseID: String {
        return "mainScreenInfoCell"
    }
    
    var descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.baseFontSize).font
        lb.text = "Трезв"
        return lb
    }()
    
    lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.bigFontSize).font
        lb.text = "0 Дней"
        return lb
    }()
    
    var viewModel: MainScreenInfoViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? MainScreenInfoViewModel else { return }
        
        self.viewModel = viewModel
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        descLabel.text = viewModel.title
        countLabel.text = viewModel.description
    }
    
    func setupConstraints() {
        contentView.addSubview(descLabel)
        contentView.addSubview(countLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            
            descLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: Styles.Sizes.stadartVInset),
            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
        ])
    }
}
