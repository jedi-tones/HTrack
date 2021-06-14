//
//  MainTabBarTabs.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

enum MainTabBarTabs: CaseIterable {
    case main
    case friends
    
    var title: String {
        switch self {
        
        case .main:
           return "Статистика"
        case .friends:
           return "Друзья"
        }
    }
    
    var image: UIImage {
        switch self {
        
        case .main:
            return Images.tabBarUser
        case .friends:
            return Images.tabBarFriends
        }
    }
    
    var tag: Int {
        switch self {
        
        case .main:
            return 0
        case .friends:
            return 1
        }
    }
}
