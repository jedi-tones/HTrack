//
//  BaseCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/5/21.
//

import UIKit

class BaseCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "baseCell"
    }
    
    var needAnimationTap = true
    
    func configure(viewModel: CellViewModel?) {
        
    }
}
