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
           return "Anonym"
        case .friends:
            return LocDic.friends
        }
    }
    
    var image: UIImage {
        switch self {
        
        case .main:
            return Styles.Images.tabBarMainOff
        case .friends:
            return Styles.Images.tabBarFriendsOff
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        
        case .main:
            return Styles.Images.tabBarMainOn
        case .friends:
            return Styles.Images.tabBarFriendsOn
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
