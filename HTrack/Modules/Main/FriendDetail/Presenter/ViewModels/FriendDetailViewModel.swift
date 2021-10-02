//
//  FriendDetailViewModewl.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

protocol FriendDetailViewModelDelegate: AnyObject {
    func removeButtonTapped()
}

class FriendDetailViewModel {
    enum ViewBlock {
        case title(title: String)
        case counter(count: Int)
        case removeButton(title: String)
    }
    
    weak var delegate: FriendDetailViewModelDelegate?
    private(set) var viewBlocks: [ViewBlock] = []
    var sheetHeaderTitle:String = ""
    
    func configure(viewBlocks: [ViewBlock])  {
        self.viewBlocks = viewBlocks
    }
}

extension FriendDetailViewModel {
    func tapRemoveButton() {
        delegate?.removeButtonTapped()
    }
}
