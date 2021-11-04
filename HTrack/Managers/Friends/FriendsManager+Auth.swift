//
//  FriendsManager+Auth.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import FirebaseAuth

extension FriendsManager: FirebaseAuthListner {
    func logOut() {
        friendsRequestManager.unsubscribeFriendsListner()
        friendsRequestManager.unsubscribeInputRequestsListner()
        
        friendsP = []
        inputRequestsP = []
        
        outputRequests = []
        updateOutputRequsts(outputRequests)
    }
    
    func logIn(user: User) {
        subscribeListners()
    }
}
