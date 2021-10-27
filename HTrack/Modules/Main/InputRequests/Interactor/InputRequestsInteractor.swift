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
            friendsManager.inputRequestsNotifier.subscribe(self)
            let inputRequests = friendsManager.inputRequests
            
            guard inputRequests.isNotEmpty else { return }
            
            output.updateRequestData(requests: inputRequests)
        }
    }
}

extension InputRequestsInteractor: FriendsManagerInputRequestsListner {
    func inputRequestsUpdated(request: [MRequestUser]) {
        output.updateRequestData(requests: request)
    }
}

