//
//  NotificationServiceSettingsManager.swift
//  NotificationServiceExt
//
//  Created by Jedi Tones on 11.11.2021.
//

import Foundation

class NotificationServiceSettingsManager {
    static let shared = NotificationServiceSettingsManager()
    private init() {}
    
    var badgeCount: Int? {
        get { UserDefaults.group.value(forKey: "badgeCount") as? Int}
        set { UserDefaults.group.set(newValue, forKey: "badgeCount") }
    }
}
