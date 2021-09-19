//
//  FriendsInteractor+UserListner.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import Foundation

extension FriendsInteractor: UserManagerListner {
    func userUpdated(user: MUser) {
        output.userUpdated(user: user)
    }
}
