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
            friendsManager.friendsNotifier.subscribe(self)
            let friends = friendsManager.friends
            
            guard friends.isNotEmpty else { return }
            output.updateFriendsData(friends: friends)
        }
    }
}


extension FriendsCollectionInteractor: FriendsManagerFriendsListner {
    func friendsUpdated(friends: [MUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.updateFriendsData(friends: friends)
    }
}
