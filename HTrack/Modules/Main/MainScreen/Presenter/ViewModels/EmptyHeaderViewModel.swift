//
//  EmptyHeaderViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 7/9/21.
//

import UIKit

class EmptyHeaderViewModel: CellViewModel {
    
    var cell: BaseCell.Type {
        EmptyHeaderCell.self
    }
    
    var height: CGFloat = 0
}

extension EmptyHeaderViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(height)
    }
    
    static func == (lhs: EmptyHeaderViewModel, rhs: EmptyHeaderViewModel) -> Bool {
        lhs.height == rhs.height
    }
}
