//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class WelcomeInteractor {
    weak var output: WelcomeInteractorOutput!

    lazy var appManager = AppManager.shared
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - WelcomeInteractorInput
extension WelcomeInteractor: WelcomeInteractorInput {
    func signInWithApple() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.authWithApple {[weak self] result in
            switch result {
            
            case .success(let user):
                Logger.show(title: "USER AUTHORISED", text: user.email ?? "")
                self?.output.closeAuthModule()
            case .failure(let error):
                Logger.show(title: "USER AUTH ERROR", text: error.localizedDescription)
            }
        }
    }
}
