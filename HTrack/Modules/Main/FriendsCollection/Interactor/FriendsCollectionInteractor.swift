//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsCollectionInteractor {
    weak var output: FriendsCollectionInteractorOutput!
    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    let sections: [FriendsScreenSection] = [ .friends]
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        friendsManager.friendsNotifier.unsubscribe(self)
    }
}

// MARK: - FriendsCollectionInteractorInput
extension FriendsCollectionInteractor: FriendsCollectionInteractorInput {
    
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.setupSections(sections: sections)
    }
    
    func addDataListnerFor(section: FriendsScreenSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
        case .friends:
            let friends = friendsManager.friends
            if friends.isNotEmpty {
                output.updateFriendsData(friends: friends)
            }
            friendsManager.friendsNotifier.subscribe(self)
        }
    }
}


extension FriendsCollectionInteractor: FriendsManagerFriendsListner {
    func friendsUpdated(friends: [MUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) count: \(friends.count)")
        
        output.updateFriendsData(friends: friends)
    }
}
