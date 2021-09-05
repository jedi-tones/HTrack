//
//  TextCollectionCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/5/21.
//

import UIKit

class TextCollectionCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "textCollectionCell"
    }
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Трезв"
        return lb
    }()
    
    var needAnimationTap = true
    
    var viewModel: TextCollectionCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? TextCollectionCellViewModel else { return }
        
        self.viewModel = viewModel
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
        ])
    }
}
