//
//  DeeplinkManager.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

class DeeplinkManager {
    static let shared = DeeplinkManager()
    private init() { }
    private var deeplinkType: MDeeplinkType?
    
    func checkDeeplink() {
        guard let deeplinkType = deeplinkType else {
            return
        }
        
        //если ссылка была получена переходим по ней
        DeeplinkNavigator.shared.proceedToDeeplink(deeplinkType)
    }
    
    func resetDeeplink() {
        // reset deeplink after handling
        deeplinkType = nil
    }
    
    func handleRemoteNotification(_ notificationUserInfo: [AnyHashable: Any]) {
        if let deeplinkType = notificationUserInfo[MDeeplinkType.deeplinkKey] as? MDeeplinkType {
            self.deeplinkType = deeplinkType
        } else {
            self.deeplinkType = nil
        }
    }
}
