//
//  TextHeaderWithCounter.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

class TextHeaderWithCounterViewModel: CellViewModel {
    var cell: BaseCellProtocol.Type {
        TextHeaderWithCounterCell.self
    }
    
    var title = "Title"
    var count: Int?
}

extension TextHeaderWithCounterViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(count)
    }
    
    static func == (lhs: TextHeaderWithCounterViewModel, rhs: TextHeaderWithCounterViewModel) -> Bool {
        lhs.title == rhs.title && lhs.count == rhs.count
    }
}
