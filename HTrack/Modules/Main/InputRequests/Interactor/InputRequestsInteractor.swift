//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Combine

class InputRequestsInteractor {
    weak var output: InputRequestsInteractorOutput!
    var friendsManager: FriendsManagerProtocol = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    let sections: [InputRequestSection] = [ .inputRequest]
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - InputRequestsInteractorInput
extension InputRequestsInteractor: InputRequestsInteractorInput {
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.setupSections(sections: sections)
    }
    
    func inputRequestPubliser() -> AnyPublisher<[MRequestUser], Never> {
        friendsManager.inputRequestsPublisher.eraseToAnyPublisher()
    }
    
    func acceptUser(_ user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.acceptInputRequest(userID: user.userID) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error: \(error)")
            }
        }
    }
    
    func rejectUser(_ user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.rejectInputRequest(userID: user.userID) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error: \(error)")
            }
        }
    }
}
