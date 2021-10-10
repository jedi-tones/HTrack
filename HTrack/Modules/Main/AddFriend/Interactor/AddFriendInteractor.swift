//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AddFriendInteractor {
    weak var output: AddFriendInteractorOutput?
    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.outputRequestsNotifier.unsubscribe(self)
    }
}

// MARK: - AddFriendInteractorInput
extension AddFriendInteractor: AddFriendInteractorInput {
    func addDataListnerFor(section: OutputRequestSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
        case .ouputRequest:
            friendsManager.outputRequestsNotifier.subscribe(self)
            let requests = friendsManager.outputRequests
            
            guard requests.isNotEmpty else { return }
            output?.updateOutputRequestData(friends: requests)
        }
    }
    
    func sendAddFriendAction(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        
    }
    
    func getOuputRequestSection() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections:[OutputRequestSection] = [.ouputRequest]
        output?.setupSections(sections: sections)
    }
}

extension AddFriendInteractor: FriendsManagerOutputRequestsListner {
    func outputRequestsUpdated(request: [MRequestUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output?.updateOutputRequestData(friends: request)
    }
}
