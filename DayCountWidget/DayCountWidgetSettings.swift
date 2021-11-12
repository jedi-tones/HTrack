//
//  DayCountWidgetSettings.swift
//  NotificationServiceExt
//
//  Created by Jedi Tones on 11.11.2021.
//

import SwiftUI

class DayCountWidgetSettingsStorage {
    static let shared = DayCountWidgetSettingsStorage()
    private init() {}
    
    @AppStorage("currenWidgettUser", store: UserDefaults.group)
    var currentUser: Data?
}
