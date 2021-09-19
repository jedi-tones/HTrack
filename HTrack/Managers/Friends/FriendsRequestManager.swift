//
//  FriendsRequestManager.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

class FriendsRequestManager {
    static let shared = FriendsRequestManager()
    
    private init() {}
    
    let firestoreManager = FirestoreManager.shared
    
    func subscribeFriendsListner(forUserID: String, delegate: FriendsListnerDelegate) {
        firestoreManager.subscribeFriendsListner(userID: forUserID, delegate: delegate)
    }
    
    func unsubscribeFriendsListner() {
        firestoreManager.unsubscribeFriendsListner()
    }
    
    func subscribeInputRequestsListner(forUserID: String, delegate: InputRequestListnerDelegate) {
        firestoreManager.subscribeInputRequestsListner(userID: forUserID, delegate: delegate)
    }
    
    func unsubscribeInputRequestsListner() {
        firestoreManager.unsubscribeInputRequestsListner()
    }
}
