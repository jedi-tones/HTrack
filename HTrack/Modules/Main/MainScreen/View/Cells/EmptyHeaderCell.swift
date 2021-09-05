//
//  EmptyHeaderCell.swift
//  HTrack
//
//  Created by Jedi Tones on 7/9/21.
//

import UIKit

class EmptyHeaderCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "emptyHeaderCell"
    }
    var needAnimationTap = false
    private var heightConst: NSLayoutConstraint?
    private var viewModel: EmptyHeaderViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? EmptyHeaderViewModel else {
            return
        }
        
        self.viewModel = viewModel
        setHeight(height: viewModel.height)
    }
    
    func setHeight(height: CGFloat) {
        heightConst?.isActive = false
        heightConst?.constant = height
        heightConst?.isActive = true
    }
    
    func setupConstraints() {
        heightConst = heightAnchor.constraint(equalToConstant: 0)
        heightConst?.priority = .defaultLow
        heightConst?.isActive = true
    }
}
