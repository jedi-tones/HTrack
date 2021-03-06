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
        let daysCount =  friend?.startDate?.getDayCount() ?? Date().getDayCount()
        let stringDaysCount = daysCount.toString()
        return LocDic.daysCount.withArguments([stringDaysCount])
    }
    
    var daysCount: Int {
        friend?.startDate?.getDayCount() ?? 0
    }

    func tapFriend() {
        guard let friend = friend else { return }
        delegate?.didTapFriend(friend: friend)
    }
}

extension FriendViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: FriendViewModel, rhs: FriendViewModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.daysCount == rhs.daysCount
    }
}
