//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AuthInteractor {
    weak var output: AuthInteractorOutput!
    
    let appManager = AppManager.shared
    let userManager = UserManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - AuthInteractorInput
extension AuthInteractor: AuthInteractorInput {
    func authWithEmail(email: String, password: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.needAutoCheckProfileFullFilled = true
        appManager.authWithEmail(email: email,
                                 password: password) {[weak self] result in
            switch result {
            
            case .success:
                self?.output.showMainModule()
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) \(error)")
                
                self?.output.showAuthError(error: AuthError.invalidPassword)
            }
        }
    }
    
    func registerEmail(email: String, password: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.needAutoCheckProfileFullFilled = false
        appManager.registerWithEmail(email: email,
                                     password: password) {[weak self] result in
            switch result {
            
            case .success(_):
                self?.createNewUser()
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) \(error)")
                
                self?.output.showAuthError(error: AuthError.serverError)
            }
        }
    }
    
    func checkEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.checkIsEmailAlreadyRegister(email: email) {[weak self] result in
            switch result {
            
            case .success(let isRegistred):
                if isRegistred {
                    self?.output.setState(state: .auth)
                } else {
                    self?.output.setState(state: .register)
                }
            case .failure(_):
                return
            }
        }
    }
    
    private func createNewUser() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.createNewCurrentUser {[weak self] result in
            switch result {
            
            case .success(_):
                self?.output.showRegisterModule()
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) error: \(error.localizedDescription)",
                            withHeader: true,
                            withFooter: true)
            }
        }
    }
}
