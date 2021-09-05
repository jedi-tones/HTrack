//
//  BaseCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/5/21.
//

import UIKit

class BaseCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID = "baseCell"
    
    var needAnimationTap = true
    
    func configure(viewModel: CellViewModel?) {
        
    }
}
