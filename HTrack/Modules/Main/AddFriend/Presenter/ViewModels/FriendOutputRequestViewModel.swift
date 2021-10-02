//
//  AddFriendOutputRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import Foundation

protocol FriendOutputRequestViewModelDelegate: AnyObject  {
    func didTapFriend(friend: MUser)
}

class FriendOutputRequestViewModel: CellViewModel {
    weak var delegate: FriendViewModelDelegate?
    
    var cell: BaseCellProtocol.Type {
        FriendCell.self
    }

    var friend: MUser?
    
    var name: String {
        friend?.name ?? "Name"
    }
    var count: String {
        friend?.startDate?.getPeriod() ?? Date().getPeriod()
    }

    func tapFriend() {
        guard let friend = friend else { return }
        delegate?.didTapFriend(friend: friend)
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
