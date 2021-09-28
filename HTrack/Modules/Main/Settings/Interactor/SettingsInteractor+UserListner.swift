//
//  SettingsInteractor+UserListner.swift
//  HTrack
//
//  Created by Jedi Tones on 9/7/21.
//

import Foundation

extension SettingsInteractor: UserManagerListner {
    func userUpdated(user: MUser) {
        output.updateUser(user: user)
    }
}
