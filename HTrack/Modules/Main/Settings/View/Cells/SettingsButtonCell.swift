//
//  SettingsButtonCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import UIKit
import TinyConstraints

class SettingsButtonCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "textCollectionCell"
    }
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = titleColor
        lb.font = Styles.Fonts.soyuz1
        lb.text = "кнопка"
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
        titleLabel.textColor = titleColor
        backgroundColor = backColor
    }
    
    func setupConstraints() {
        contentView.edgesToSuperview()
        contentView.height(Styles.Sizes.baseButtonHeight, priority: .defaultHigh)
        contentView.addSubview(titleLabel)
        
        titleLabel.centerXToSuperview()
        titleLabel.centerYToSuperview()
        
    }
}

extension SettingsButtonCell {
    var backColor: UIColor {
        if viewModel?.sensetive ?? false {
            let friendsColorsDaysOffset = Styles.Constants.friendsColorsDaysOffset
            return Styles.Colors.progressedColor(days: friendsColorsDaysOffset)
        } else {
            return Styles.Colors.base3
        }
    }
    
    var titleColor: UIColor {
        if viewModel?.sensetive ?? false {
            return Styles.Colors.base3
        } else {
            return Styles.Colors.base1
        }
    }
}
