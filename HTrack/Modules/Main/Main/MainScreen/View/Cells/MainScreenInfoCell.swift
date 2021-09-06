//
//  MainScreenInfoCell.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

class MainScreenInfoCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "mainScreenInfoCell"
    }
    
    var needAnimationTap = false
    
    var descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Трезв"
        return lb
    }()
    
    lazy var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBiggest).font
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
        self.viewModel?.cellDelegate = self
        
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        DispatchQueue.main.async {[weak self] in
            self?.descLabel.text = viewModel.title
            self?.countLabel.text = viewModel.description
        }
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

extension MainScreenInfoCell: MainScreenInfoCellDelegate {
    func update(vm: MainScreenInfoViewModel) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) MAIN INFO UPDATED title: \(vm.title) desc: \(vm.description)",
                    withHeader: true,
                    withFooter: true)
        
        self.viewModel = vm
        DispatchQueue.main.async {[weak self] in
            self?.descLabel.text = vm.description
            self?.countLabel.text = vm.title
        }
//        setup()
    }
}
