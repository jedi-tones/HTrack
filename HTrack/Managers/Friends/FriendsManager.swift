//
//  FriendsManager.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import FirebaseAuth

protocol FriendsManagerFriendsListner {
    func friendsUpdated(friends: [MUser])
}

protocol FriendsManagerInputRequestsListner {
    func inputRequestsUpdated(request: [MRequestUser])
}

class FriendsManager {
    static let shared = FriendsManager()
    
    private init() {
        subscribeListners()
        firebaseAuthService.notifier.subscribe(self)
    }
    
    deinit {
        friendsRequestManager.unsubscribeFriendsListner()
        friendsRequestManager.unsubscribeInputRequestsListner()
        firebaseAuthService.notifier.unsubscribe(self)
    }
    
    let firebaseAuthService = FirebaseAuthManager.shared
    let friendsRequestManager = FriendsRequestManager.shared
    
    private let friendsNotifier = Notifier<FriendsManagerFriendsListner>()
    private let inputRequestsNotifier = Notifier<FriendsManagerInputRequestsListner>()
    
    var firUser: User? { firebaseAuthService.getCurrentUser() }
    var friends: [MUser] = []
    var inputRequests: [MRequestUser] = []
    
    func subscribeListners() {
        do {
            try subscribeFriendsListner()
            try subscribeInputRequestsListner()
        } catch {
            Logger.show(title: "subscribe Listners ERROR",
                        text: "\(String(describing: error.localizedDescription))",
                        withHeader: true,
                        withFooter: true)
        }
    }
    
    func unsubscribeListners() {
        
    }
    
    func subscribeFriendsNotifier(listner: FriendsManagerFriendsListner) -> [MUser] {
        friendsNotifier.subscribe(listner)
        return friends
    }
    
    func subscribeInputRequestsNotifier(listner: FriendsManagerInputRequestsListner) -> [MRequestUser] {
        inputRequestsNotifier.subscribe(listner)
        return inputRequests
    }
    
    func unsubscribeFriendsNotifier(listner: FriendsManagerFriendsListner) {
        friendsNotifier.unsubscribe(listner)
    }
    
    func unsubscribeInputRequestsNotifier(listner: FriendsManagerInputRequestsListner) {
        inputRequestsNotifier.unsubscribe(listner)
    }
    
    func updateFriends(_ friends: [MUser]) {
        Logger.show(title: "Friends updated",
                    text: "Friends \(String(describing: friends))",
                    withHeader: true,
                    withFooter: true)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.friendsNotifier.forEach({$0.friendsUpdated(friends: friends)})
        }
    }
    
    func updateInputRequsts(_ requests: [MRequestUser]) {
        Logger.show(title: "InputRequests updated",
                    text: "requests \(String(describing: requests))",
                    withHeader: true,
                    withFooter: true)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.inputRequestsNotifier.forEach({$0.inputRequestsUpdated(request: requests)})
        }
    }
}
