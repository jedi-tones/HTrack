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
        get { UserDefaults(suiteName: "group.flava.app.HTrack")?.value(forKey: "badgeCount") as? Int}
        set { UserDefaults(suiteName: "group.flava.app.HTrack")?.set(newValue, forKey: "badgeCount") }
    }
}
