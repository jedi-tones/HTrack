//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class InputRequestsInteractor {
    weak var output: InputRequestsInteractorOutput!
    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    var authManager = FirebaseAuthManager.shared
    let sections: [InputRequestSection] = [ .inputRequest]
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        friendsManager.inputRequestsNotifier.unsubscribe(self)
    }
}

// MARK: - InputRequestsInteractorInput
extension InputRequestsInteractor: InputRequestsInteractorInput {
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.setupSections(sections: sections)
    }
    
    func addDataListnerFor(section: InputRequestSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
            
        case .inputRequest:
            let inputRequests = friendsManager.inputRequests
            if inputRequests.isNotEmpty {
                output.updateRequestData(requests: inputRequests)
            }
            
            friendsManager.inputRequestsNotifier.subscribe(self)
        }
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

extension InputRequestsInteractor: FriendsManagerInputRequestsListner {
    func inputRequestsUpdated(request: [MRequestUser]) {
        output.updateRequestData(requests: request)
    }
}

