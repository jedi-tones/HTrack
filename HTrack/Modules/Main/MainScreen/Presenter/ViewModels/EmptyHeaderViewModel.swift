//
//  EmptyHeaderViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 7/9/21.
//

import UIKit

class EmptyHeaderViewModel: CellViewModel {
    
    var cell: BaseCellProtocol.Type {
        EmptyHeaderCell.self
    }
    var needAnimationTap = false
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
