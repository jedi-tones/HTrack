//
//  AppManager+AuthListner.swift
//  HTrack
//
//  Created by Jedi Tones on 05.11.2021.
//

import Foundation
import FirebaseAuth

extension AppManager {
    func subscribeAuthStatePublisher() {
        firebaseAuthService.userStatePublisher
            .sink {[weak self] userState in
                switch userState {
                    
                case .authorized:
                    self?.afterLogIn()
                case .notAuthorized:
                    self?.afterLogOut()
                case .notAvalible:
                    break
                }
            }
            .store(in: &subscribers)
    }
    
    private func afterLogIn() {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.afterLogin()
        pushFCMManger.getToken()
    }
    
    private func afterLogOut() {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.removeFCMToken()
        userManager.currentUser = nil
        settingsStorage.resetUserStorage()
        friendsManager.afterLogout()
    }
}


