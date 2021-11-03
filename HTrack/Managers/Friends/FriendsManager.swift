//
//  FriendsManager.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import FirebaseAuth
import Combine

protocol FriendsManagerFriendsListner {
    func friendsUpdated(friends: [MUser])
}

protocol FriendsManagerInputRequestsListner {
    func inputRequestsUpdated(request: [MRequestUser])
}

protocol FriendsManagerOutputRequestsListner {
    func outputRequestsUpdated(request: [MRequestUser])
}

protocol FriendsManagerProtocol {
    var friendsPublisher: Published<[MUser]>.Publisher { get }
    var friendsP: [MUser] { get }
//    var inputRequestsPublisher: Published<[MRequestUser]>.Publisher { get }
//    var outputRequestsRequestsPublisher: Published<[MRequestUser]>.Publisher { get }
}

class FriendsManager: FriendsManagerProtocol {
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
    
    @Published var friendsP: [MUser] = []
    var inputRequests: [MRequestUser] = []
    var outputRequests: [MRequestUser] = []
    
    var friendsPublisher: Published<[MUser]>.Publisher { $friendsP }
//    var inputRequestsPublisher: Published<[MRequestUser]>.Publisher { $inputRequests }
//    var outputRequestsRequestsPublisher: Published<[MRequestUser]>.Publisher { $outputRequests }
    
    var serialFriendsQ = DispatchQueue(label: "serialFriends")
    var serialInputQ = DispatchQueue(label: "serialInput")
    var serialOutputQ = DispatchQueue(label: "serialOutput")
    
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
        serialFriendsQ.async {[weak self] in
            Logger.show(title: "Friends updated",
                        text: "Friends \(String(describing: friends))",
                        withHeader: true,
                        withFooter: true)
            
            guard let self = self else { return }
            
            self.friendsNotifier.forEach({$0.friendsUpdated(friends: friends)})
        }
    }
    
    func updateInputRequsts(_ requests: [MRequestUser]) {
        serialInputQ.async {[weak self] in
            Logger.show(title: "InputRequests updated",
                        text: "requests \(String(describing: requests))",
                        withHeader: true,
                        withFooter: true)
            
            guard let self = self else { return }
            
            self.inputRequestsNotifier.forEach({$0.inputRequestsUpdated(request: requests)})
        }
    }
    
    func updateOutputRequsts(_ requests: [MRequestUser]) {
        serialOutputQ.async {[weak self] in
            Logger.show(title: "OutputRequests updated",
                        text: "requests \(String(describing: requests))",
                        withHeader: true,
                        withFooter: true)
            
            guard let self = self else { return }
            
            self.outputRequestsNotifier.forEach({$0.outputRequestsUpdated(request: requests)})
        }
    }
}
