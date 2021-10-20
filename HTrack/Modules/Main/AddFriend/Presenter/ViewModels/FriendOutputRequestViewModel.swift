//
//  AddFriendOutputRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import Foundation

protocol FriendOutputRequestViewModelDelegate: AnyObject  {
    func didTapCancelRequst(friend: MRequestUser)
}

class FriendOutputRequestViewModel: CellViewModel {
    weak var delegate: FriendOutputRequestViewModelDelegate?
    
    var cell: BaseCellProtocol.Type {
        OutputFriendRequestCell.self
    }

    var friend: MRequestUser?
    
    var name: String {
        friend?.nickname ?? "Name"
    }

    func tapCancel() {
        guard let friend = friend else { return }
        delegate?.didTapCancelRequst(friend: friend)
    }
}

extension FriendOutputRequestViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(friend)
    }
    
    static func == (lhs: FriendOutputRequestViewModel, rhs: FriendOutputRequestViewModel) -> Bool {
        lhs.friend == rhs.friend
    }
}
