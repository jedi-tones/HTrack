//
//  OutputFriendRequestCell.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

class OutputFriendRequestCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "outputFriendRequestCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBig).font
        lb.text = "Name"
        return lb
    }()
    
    var viewModel: FriendOutputRequestViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? FriendOutputRequestViewModel else { return }
        
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
        }
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        
        nameLabel.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                                              left: Styles.Sizes.standartHInset,
                                                                              bottom: .zero,
                                                                              right: Styles.Sizes.standartHInset))
       
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

extension OutputFriendRequestCell {
    var backColor: UIColor {
        Styles.Colors.mySecondBackgroundColor()
    }
    
    var labelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
