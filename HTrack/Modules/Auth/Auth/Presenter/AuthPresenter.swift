//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AuthPresenter {
    weak var output: AuthModuleOutput?
    weak var view: AuthViewInput!
    var router: AuthRouterInput!
    var interactor: AuthInteractorInput!
    
    var _state: AuthViewController.AuthViewControllerState = .notChecked
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - AuthViewOutput
extension AuthPresenter: AuthViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
    
    func checkEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setState(state: .load)
        _state = .notChecked
        interactor.checkEmail(email: email)
    }
    
    func registerEmail(email: String, password: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setState(state: .load)
        _state = .register
        interactor.registerEmail(email: email, password: password)
    }
    
    func authWithEmail(email: String, password: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setState(state: .load)
        _state = .auth
        interactor.authWithEmail(email: email, password: password)
    }
}

// MARK: - AuthInteractorOutput
extension AuthPresenter: AuthInteractorOutput {
    func setState(state: AuthViewController.AuthViewControllerState) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setState(state: state)
    }
    
    func showRegisterModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showRegisterModule()
    }
    
    func showMainModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showMainModule()
    }
    
    func showAuthError(error: AuthError) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) error: \(error)")
        
        view.setState(state: _state)
    }
}

// MARK: - AuthModuleInput
extension AuthPresenter: AuthModuleInput {
    func configure(output: AuthModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
