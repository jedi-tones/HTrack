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

protocol FriendsManagerOutputRequestsListner {
    func outputRequestsUpdated(request: [MRequestUser])
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
    
    let friendsNotifier = Notifier<FriendsManagerFriendsListner>()
    let inputRequestsNotifier = Notifier<FriendsManagerInputRequestsListner>()
    let outputRequestsNotifier = Notifier<FriendsManagerOutputRequestsListner>()
    
    var firUser: User? { firebaseAuthService.getCurrentUser() }
    var friends: [MUser] = []
    var inputRequests: [MRequestUser] = []
    var outputRequests: [MRequestUser] = []
    
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
    
    func updateOutputRequsts(_ requests: [MRequestUser]) {
        Logger.show(title: "OutputRequests updated",
                    text: "requests \(String(describing: requests))",
                    withHeader: true,
                    withFooter: true)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.outputRequestsNotifier.forEach({$0.outputRequestsUpdated(request: requests)})
        }
    }
}
