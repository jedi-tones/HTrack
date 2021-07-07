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
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Colors.myLabelColor()
        lb.font = Fonts.AvenirFonts.avenirNextRegular(size: 15).font
        lb.text = "Трезв"
        return lb
    }()
    
    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Colors.myLabelColor()
        lb.font = Fonts.AvenirFonts.avenirNextBold(size: 24).font
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
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Sizes.baseVInset),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Sizes.baseVInset),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Sizes.baseVInset)
        ])
    }
}
