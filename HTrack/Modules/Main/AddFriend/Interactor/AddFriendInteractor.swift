//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Dispatch

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
        
        DispatchQueue.global().async {
            self.userManager.checkUserIsAvalible(withName: name) { result in
                switch result {
                    
                case .success(let requestUser):
                    Logger.show(title: "SUCCESS",
                                text: "\(type(of: self)) - \(#function) request user: \(String(describing: requestUser))")
                case .failure(let error):
                    Logger.show(title: "Error",
                                text: "\(type(of: self)) - \(#function) error \(error)")
                }
            }
        }
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
