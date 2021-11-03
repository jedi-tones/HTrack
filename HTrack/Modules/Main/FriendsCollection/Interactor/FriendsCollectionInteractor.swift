//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Combine

class FriendsCollectionInteractor {
    weak var output: FriendsCollectionInteractorOutput!
    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    
    let sections: [FriendsScreenSection] = [ .friends]
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendsCollectionInteractorInput
extension FriendsCollectionInteractor: FriendsCollectionInteractorInput {
    
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.setupSections(sections: sections)
    }
    
    func friendsPublisher() -> AnyPublisher<[MUser], Never> {
        friendsManager.friendsPublisher.eraseToAnyPublisher()
    }
}
