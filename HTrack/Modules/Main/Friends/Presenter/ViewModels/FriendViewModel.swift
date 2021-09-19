//
//  FriendViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

protocol FriendViewModelDelegate: AnyObject  {
    func didTapFriend(friend: MUser)
}

class FriendViewModel: CellViewModel {
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

extension FriendViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(friend)
    }
    
    static func == (lhs: FriendViewModel, rhs: FriendViewModel) -> Bool {
        lhs.friend == rhs.friend
    }
}
