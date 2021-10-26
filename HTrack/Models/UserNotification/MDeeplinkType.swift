//
//  MDeeplinkType.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

enum MDeeplinkType: Codable {
    case main
    case requests
    case friends
    
    var description: String {
        switch self {
        
        case .main:
            return "main"
        case .requests:
            return "requests"
        case .friends:
            return "friends"
        }
    }
    
    static var deeplinkKey:String { "deeplinkType" }
}
