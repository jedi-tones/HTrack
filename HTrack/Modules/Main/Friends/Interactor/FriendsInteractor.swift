//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsInteractor {
    weak var output: FriendsInteractorOutput!

    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.unsubscribeFriendsNotifier(listner: self)
        friendsManager.unsubscribeInputRequestsNotifier(listner: self)
        userManager.notifier.unsubscribe(self)
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
        
        let sections: [FriendsScreenSection] = [.inputRequest, .friends]
        output.setupSections(sections: sections)
    }
    
    func addDataListnerFor(section: FriendsScreenSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        //for test
        if true {
            
        }
        
        switch section {
        
        case .inputRequest:
            let inputRequests = friendsManager.subscribeInputRequestsNotifier(listner: self)
            output.updateRequestData(requests: inputRequests)
        case .friends:
            let friends = friendsManager.subscribeFriendsNotifier(listner: self)
            output.updateFriendsData(friends: friends)
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
