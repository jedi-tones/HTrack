//
//  SettingsStorage.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

class SettingsStorage {
    static let shared = SettingsStorage()
    
    private init() {}
    
    @UserDefault(key: UserDefaultKey.startDate)
    var startDate: Double?
    
    @UserDefault(key: UserDefaultKey.fcmKey)
    var fcmKey: String?
    
    @GroupUserDefault(key: UserDefaultKey.badgeCount)
    var badgeCount: Int?
    
    @GroupUserDefault(key: UserDefaultKey.currenWidgettUser)
    var currentUser: Data?
    
    func resetUserStorage() {
        startDate = nil
        fcmKey = nil
        badgeCount = nil
        currentUser = nil
    }
}
