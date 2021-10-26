//
//  DeeplinkNavigator.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

class DeeplinkNavigator {
    static let shared = DeeplinkNavigator()
    private init() {}
    
    func proceedToDeeplink(_ type: MDeeplinkType) {
        DeeplinkManager.shared.resetDeeplink()
        
        switch type {
        
        case .main:
            Logger.show(title: "DeeplinkNavigator", text: "main")
        case .requests:
            Logger.show(title: "DeeplinkNavigator", text: "requests")
        case .friends:
            Logger.show(title: "DeeplinkNavigator", text: "friends")
        }
    }
}
