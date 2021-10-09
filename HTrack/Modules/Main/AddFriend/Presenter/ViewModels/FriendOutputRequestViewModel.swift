//
//  AddFriendOutputRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import Foundation

protocol FriendOutputRequestViewModelDelegate: AnyObject  {
    func didTapCancelRequst(friend: MUser)
}

class FriendOutputRequestViewModel: CellViewModel {
    weak var delegate: FriendOutputRequestViewModelDelegate?
    
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
