//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsInteractor {
    weak var output: FriendsInteractorOutput!

    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    
    init() {}
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
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
    
    func getPages() -> [FriendsPage] {
        return FriendsPage.allCases
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
