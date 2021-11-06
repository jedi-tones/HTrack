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
    
    func subscribeOutputRequestsListner(forUserID: String, delegate: OutputRequestListnerDelegate) {
        firestoreManager.subscribeOutputRequestsListner(userID: forUserID, delegate: delegate)
    }
    
    func unsubscribeOutputRequestsListner() {
        firestoreManager.unsubscribeOutputRequestsListner()
    }
    
    func checkCanAddFriendRequest(userName: String, complition:((Result<MUser,Error>) -> Void)?) {
        firestoreManager.checkCanAddFriendRequest(userName: userName, complition: complition)
    }
    
    func sendAddFriendRequst(currentMUser: MUser, toUser: MUser?, userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        firestoreManager.sendAddFriendRequst(currentMUser: currentMUser,
                                             toUser: toUser,
                                             userID: userID,
                                             complition: complition)
    }
    
    func acceptInputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        firestoreManager.acceptInputRequest(userID: userID, complition: complition)
    }
    
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        firestoreManager.rejectInputRequest(userID: userID, complition: complition)
    }
    
    func rejectOutputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        firestoreManager.rejectOutputRequest(userID: userID, complition: complition)
    }
    
    func removeFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        firestoreManager.removeFriend(userID: userID, complition: complition)
    }
    
    func updateStartDateInFriends(friendsIDs: [String], startDay: Double, complition: @escaping(Result<Bool, Error>) -> Void) {
        firestoreManager.updateStartDateInFriends(friendsIDs: friendsIDs, startDay: startDay, complition: complition)
    }
    
    func updateFCMTokenInFriends(friendsIDs: [String], token: String, complition: @escaping(Result<Bool, Error>) -> Void) {
        firestoreManager.updateFCMTokenInFriends(friendsIDs: friendsIDs, token: token, complition: complition)
    }
}
