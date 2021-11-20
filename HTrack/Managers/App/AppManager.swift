//
//  AppManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation
import Combine

class AppManager {
    static let shared = AppManager()
    private init() {}
    
    let appleAuthService = AppleAuthService.shared
    let firebaseAuthService =  FirebaseAuthManager.shared
    let userManager = UserManager.shared
    let friendsManager = FriendsManager.shared
    let settingsStorage = SettingsStorage.shared
    let pushFCMManger = PushFCMManager.shared
    let pushNotificationManager = PushNotificationManager.shared
    let appLifecycleManager = AppLifecycleManager.shared
    
    var needAutoCheckProfileFullFilled = true
    var subscribers: Set<AnyCancellable> = []
    
    func afterStart() {
        subscribeUpdateFCMToken()
        subscribeAuthStatePublisher()
        
        pushNotificationManager.requestNotificationAuth()
        pushFCMManger.registerDelegate()
    }
    
    private func subscribeUpdateFCMToken() {
        pushFCMManger.fcmTokenPublisher
            .sink {[weak self] updatedToken in
                Logger.show(title: "PUBLISHER",
                            text: "\(type(of: self)) - \(#function) updated token \(updatedToken)")
                self?.settingsStorage.fcmKey = updatedToken
                self?.userManager.updateFCMToken()
            }
            .store(in: &subscribers)
    }
}
