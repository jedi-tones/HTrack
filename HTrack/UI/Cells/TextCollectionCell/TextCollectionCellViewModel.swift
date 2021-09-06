//
//  TextCollectionCellViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/5/21.
//

import Foundation

protocol TextCollectionCellViewModelDelegate {
    func didTap(title: String)
}

class TextCollectionCellViewModel: CellViewModel, Hashable {
    
    var delegate: TextCollectionCellViewModelDelegate?
    var cell: BaseCellProtocol.Type {
        TextCollectionCell.self
    }
    var needAnimationTap = true
    var title: String?
    
    func didTap() {
        delegate?.didTap(title: title ?? "")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: TextCollectionCellViewModel, rhs: TextCollectionCellViewModel) -> Bool {
        lhs.title == rhs.title
    }
}
