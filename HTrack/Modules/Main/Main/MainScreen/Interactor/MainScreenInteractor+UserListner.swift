//
//  MainScreenInteractor+UserListner.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import Foundation

extension MainScreenInteractor: UserManagerListner {
    func userUpdated(user: MUser) {
        output.updateUserStat(user: user)
    }
}
