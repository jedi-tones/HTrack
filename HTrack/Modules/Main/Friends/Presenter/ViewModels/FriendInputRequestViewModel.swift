//
//  FriendInputRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

protocol FriendInputRequestViewModelDelegate: AnyObject  {
    func acceptUser(user: MRequestUser)
    func cancelUser(user: MRequestUser)
    func blockUser(user: MRequestUser)
}

class FriendInputRequestViewModel: CellViewModel {
    weak var delegate: FriendInputRequestViewModelDelegate?
    
    var cell: BaseCellProtocol.Type {
        RequestCell.self
    }

    var requestUser: MRequestUser?
    
    var name: String {
        requestUser?.nickname ?? "Name"
    }
    var userID: String {
        requestUser?.userID ?? "id"
    }

    func acceptUser() {
        guard let requestUser = requestUser else { return }
        delegate?.acceptUser(user: requestUser)
    }
    
    func cancelUser() {
        guard let requestUser = requestUser else { return }
        delegate?.cancelUser(user: requestUser)
    }
    
    func blockUser() {
        guard let requestUser = requestUser else { return }
        delegate?.blockUser(user: requestUser)
    }
}

extension FriendInputRequestViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(requestUser)
    }
    
    static func == (lhs: FriendInputRequestViewModel, rhs: FriendInputRequestViewModel) -> Bool {
        lhs.requestUser == rhs.requestUser
    }
}
