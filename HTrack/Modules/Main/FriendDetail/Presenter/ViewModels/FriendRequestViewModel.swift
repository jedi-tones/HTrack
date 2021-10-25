//
//  FriendRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 10/25/21.
//

import Foundation

protocol FriendRequestViewModelDelegate: AnyObject {
    func acceptButtonTapped()
    func rejectButtonTapped()
}

class FriendRequestViewModel {
    enum ViewBlock {
        case name(title: String)
        case acceptButton(title: String)
        case rejectButton(title: String)
    }
    
    weak var delegate: FriendRequestViewModelDelegate?
    private(set) var viewBlocks: [ViewBlock] = []
    
    func configure(viewBlocks: [ViewBlock])  {
        self.viewBlocks = viewBlocks
    }
}

extension FriendRequestViewModel {
    func tapAcceptButton() {
        delegate?.acceptButtonTapped()
    }
    
    func tapRejectButton() {
        delegate?.rejectButtonTapped()
    }
}
