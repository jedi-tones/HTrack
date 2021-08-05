//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AuthPresenter {
    weak var output: AuthModuleOutput?
    weak var view: AuthViewInput!
    var router: AuthRouterInput!
    var interactor: AuthInteractorInput!

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
    
    func registerEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        view.setState(state: .notChecked)
    }
    
    func checkEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        view.setState(state: .auth)
        
    }
    
    func authWithEmail(email: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        view.setState(state: .notChecked)
    }
}

// MARK: - AuthInteractorOutput
extension AuthPresenter: AuthInteractorOutput {
    func setState(state: AuthViewController.AuthViewControllerState) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func showRegisterModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func showMainModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
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
