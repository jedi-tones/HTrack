//
//  FriendInputRequestViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

protocol FriendInputRequestViewModelDelegate: AnyObject  {
    func tapInputRequest(user: MRequestUser)
    func tapRejectRequest(user: MRequestUser)
    func tapAcceptRequest(user: MRequestUser)
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

    func tapAcceptIcon() {
        guard let requestUser = requestUser else { return }
        delegate?.tapAcceptRequest(user: requestUser)
    }
    
    func tapRejectIcon() {
        guard let requestUser = requestUser else { return }
        delegate?.tapRejectRequest(user: requestUser)
    }
    
    func tapInputRequestCell() {
        guard let requestUser = requestUser else { return }
        delegate?.tapInputRequest(user: requestUser)
    }
}

extension FriendInputRequestViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: FriendInputRequestViewModel, rhs: FriendInputRequestViewModel) -> Bool {
        lhs.name == rhs.name
    }
}
