//
//  MainTabBarInteractor+FirebaseAuth.swift
//  HTrack
//
//  Created by Jedi Tones on 9/3/21.
//

import Foundation
import FirebaseAuth

extension MainTabBarInteractor: FirebaseAuthListner {
    func logOut() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)",
                    withHeader: true,
                    withFooter: true)
        output.showAuth()
    }
    
    func logIn(user: User) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) user: \(user)",
                    withHeader: true,
                    withFooter: true)
        
        checkCurrentUserProfile()
    }
}
