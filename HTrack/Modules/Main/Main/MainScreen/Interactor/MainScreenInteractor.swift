//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class MainScreenInteractor {
    weak var output: MainScreenInteractorOutput!

    let userManager = UserManager.shared
    let authManager = FirebaseAuthManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.unsubscribe(self)
        authManager.notifier.unsubscribe(self)
    }
}

// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections = [MainScreenSection.info]
        output.setupSections(sections: sections)
    }
    
    func getUser() -> MUser? {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.subscribe(self)
        authManager.notifier.subscribe(self)
        
        if let user = userManager.currentUser {
            return user
        } else {
            return nil
        }
    }
}
