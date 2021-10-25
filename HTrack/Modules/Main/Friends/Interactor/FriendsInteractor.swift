//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsInteractor {
    weak var output: FriendsInteractorOutput!

    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    
    let sections: [FriendsScreenSection] = [.inputRequest, .friends]
    init() {
        
    }
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.friendsNotifier.unsubscribe(self)
        friendsManager.inputRequestsNotifier.unsubscribe(self)
        userManager.notifier.unsubscribe(self)
        authManager.notifier.unsubscribe(self)
    }
}

// MARK: - FriendsInteractorInput
extension FriendsInteractor: FriendsInteractorInput {
    func subscribeUserListner() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.subscribe(self)
        guard let user = userManager.currentUser else { return }
        output.userUpdated(user: user)
    }
    
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.setupSections(sections: sections)
    }
    
    func addDataListnerFor(section: FriendsScreenSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
        
        case .inputRequest:
            friendsManager.inputRequestsNotifier.subscribe(self)
            let inputRequests = friendsManager.inputRequests
            
            guard inputRequests.isNotEmpty else { return }
            
            output.updateRequestData(requests: inputRequests)
        case .friends:
            friendsManager.friendsNotifier.subscribe(self)
            let friends = friendsManager.friends
            
            guard friends.isNotEmpty else { return }
            output.updateFriendsData(friends: friends)
        }
    }
    
    func cancelUserRequest(id: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.rejectInputRequest(userID: id) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error - \(error)")
            }
        }
    }
    
    func accepUserRequest(id: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.acceptInputRequest(userID: id) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error - \(error)")
            }
        }
    }
}

extension FriendsInteractor: FriendsManagerFriendsListner {
    func friendsUpdated(friends: [MUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) friends: \(friends)")
        
        output.updateFriendsData(friends: friends)
    }
}

extension FriendsInteractor: FriendsManagerInputRequestsListner {
    func inputRequestsUpdated(request: [MRequestUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) requests: \(request)")
        
        output.updateRequestData(requests: request)
    }
}
