//
//  TextHeaderWithCounterCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

class TextHeaderWithCounterCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "textHeaderWithCounterCell"
    }
    var needAnimationTap = false
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = titleColor
        lb.font = Styles.Fonts.bold2
        return lb
    }()
    
    lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.textColor = titleColor
        lb.font = Styles.Fonts.bold2
        lb.isHidden = true
        return lb
    }()
    
    private var viewModel: TextHeaderWithCounterViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? TextHeaderWithCounterViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        DispatchQueue.main.async {[weak self] in
            self?.titleLabel.text = viewModel.title
            
            if let count = viewModel.count {
                self?.countLabel.isHidden = false
                self?.countLabel.text = String(count)
            } else {
                self?.countLabel.isHidden = true
            }
        }
    }
    
    func setup() {
        backgroundColor = headerBackgroundColor
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Styles.Sizes.mediumHInset),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.baseVInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
            
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Styles.Sizes.standartHInset),
            countLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            countLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
}

extension TextHeaderWithCounterCell {
    var titleColor: UIColor {
        return Styles.Colors.myLabelColor()
    }
    
    var headerBackgroundColor: UIColor {
        return Styles.Colors.myBackgroundColor()
    }
}
