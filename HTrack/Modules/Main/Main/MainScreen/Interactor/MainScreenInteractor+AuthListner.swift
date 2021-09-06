//
//  MainScreenInteractor+AuthListner.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import FirebaseAuth

extension MainScreenInteractor: FirebaseAuthListner {
    func logOut() {
        output.updateUserStat(user: nil)
    }
    
    func logIn(user: User) {
        return
    }
}
