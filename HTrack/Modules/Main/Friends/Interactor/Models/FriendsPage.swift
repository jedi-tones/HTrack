//
//  FriendsPage.swift
//  HTrack
//
//  Created by Jedi Tones on 10/27/21.
//

import Foundation

enum FriendsPage: String, CaseIterable  {
    case friendsCollection
    case inputRequestCollection
    
    var controllerTag: String {
        switch self {
            
        case .friendsCollection:
            return String(describing: FriendsCollectionModule.self)
        case .inputRequestCollection:
            return String(describing: InputRequestsModule.self)
        }
    }
    
    var title: String {
        switch self {
        case .friendsCollection:
            return LocDic.friends
        case .inputRequestCollection:
            return LocDic.friendsRequests
        }
    }
    
    var index: Int {
        switch self {
        case .friendsCollection:
            return 0
        case .inputRequestCollection:
            return 1
        }
    }
}
