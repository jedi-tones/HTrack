//
//  WidgetManager.swift
//  HTrack
//
//  Created by Jedi Tones on 11.11.2021.
//

import Foundation
import WidgetKit

class WidgetManager {
    static let shared = WidgetManager()
    private init() {}
    
    lazy var appManager = AppManager.shared
    
    func updateUser(_ user: MUser) {
        let widgetUser = WidgetUserModel(name: user.name, startDate: user.startDate)
        let widgetUserData = widgetUser.toData()
        appManager.settingsStorage.currentUser = widgetUserData
        
        updateWidget()
    }
    
     func updateWidget() {
        WidgetCenter.shared
            .reloadTimelines(ofKind: "DayCountWidget")
    }
}
