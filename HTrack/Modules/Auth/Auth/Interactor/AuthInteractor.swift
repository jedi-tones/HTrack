//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AuthInteractor {
    weak var output: AuthInteractorOutput!
    
    let appManager = AppManager.shared
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - AuthInteractorInput
extension AuthInteractor: AuthInteractorInput {
    func registerEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
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
}
