//
//  RequestCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit
import TinyConstraints

class RequestCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "requestCell"
    }
    
    var needAnimationTap = false
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = nameLabelColor
        lb.font = Styles.Fonts.bold2
        lb.text = "Name"
        return lb
    }()
    
    lazy var acceptButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "принять")
            .setTitleFont(font: Styles.Fonts.normal1)
            .setButtonColor(color: self.acceptButtonColor)
            .setTextColor(color: self.acceptButtonLabelColor)
        bt.action = { [weak self] in
            self?.viewModel?.acceptUser()
        }
        return bt
    }()
    
    lazy var cancelButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow()
        bt.setTitle(title: "отклонить")
            .setTitleFont(font: Styles.Fonts.normal1)
            .setButtonColor(color: self.cancelButtonColor)
            .setTextColor(color: self.cancelButtonLabelColor)
        bt.action = { [weak self] in
            self?.viewModel?.cancelUser()
        }
        return bt
    }()
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.addArrangedSubview(self.acceptButton)
        stack.addArrangedSubview(self.cancelButton)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Styles.Sizes.standartHInset
        return stack
    }()
    
    var viewModel: FriendInputRequestViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupView()
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
            self?.nameLabel.text = "@\(viewModel.name.uppercased())"
        }
    }
    
    private func setupView() {
        backgroundColor = backColor
    }
    
    func setupConstraints() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        
        nameLabel.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: Styles.Sizes.standartHInset,
                                                                              left: Styles.Sizes.standartHInset,
                                                                              bottom: .zero,
                                                                              right: Styles.Sizes.standartHInset))
        stackView.edgesToSuperview(excluding: .top, insets: TinyEdgeInsets(top: .zero,
                                                                              left: Styles.Sizes.standartHInset,
                                                                              bottom: Styles.Sizes.standartHInset,
                                                                              right: Styles.Sizes.standartHInset))
        stackView.topToBottom(of: nameLabel, offset: Styles.Sizes.standartHInset)
    }
}

extension RequestCell {
    var backColor: UIColor {
        Styles.Colors.mySecondBackgroundColor()
    }
    
    var acceptButtonColor: UIColor {
        Styles.Colors.myFilledButtonColor()
    }
    
    var acceptButtonLabelColor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
    
    var cancelButtonColor: UIColor {
        Styles.Colors.myFilledDisableButtonColor()
    }
    
    var cancelButtonLabelColor: UIColor {
        Styles.Colors.myFilledButtonLabelColor()
    }
    
    var nameLabelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
