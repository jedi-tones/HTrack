//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class WelcomeInteractor {
    weak var output: WelcomeInteractorOutput!

    lazy var appManager = AppManager.shared
    lazy var userManager = UserManager.shared
    
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
                self?.output.authWithAppleComplite(user: user)
            case .failure(let error):
                Logger.show(title: "USER AUTH ERROR", text: error.localizedDescription)
            }
        }
    }
    
    func checkCurrentUserProfile() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.checkCurrentUserProfileRegistration {[weak self] result in
            switch result {
            
            case .success(let state):
                switch state {
                
                case .filled:
                    self?.output.showMainScreen()
                case .needComplite:
                    self?.output.showCompliteRegistration()
                case .notExist:
                    self?.createNewCurrentUser()
                }
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) error: \(error.localizedDescription)",
                            withHeader: true,
                            withFooter: true)
            }
        }
    }
    
    func createNewCurrentUser() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.createNewCurrentUser {[weak self] result in
            switch result {
            
            case .success(_):
                self?.output.showCompliteRegistration()
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) error: \(error.localizedDescription)",
                            withHeader: true,
                            withFooter: true)
            }
        }
    }
}
