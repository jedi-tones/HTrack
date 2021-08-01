//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class WelcomePresenter {
    weak var output: WelcomeModuleOutput?
    weak var view: WelcomeViewInput!
    var router: WelcomeRouterInput!
    var interactor: WelcomeInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - WelcomeViewOutput
extension WelcomePresenter: WelcomeViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
    
    func signInWithApple() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor.signInWithApple()
    }
    
    func signInWithEmail() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.opensSignInWithEmail()
    }
}

// MARK: - WelcomeInteractorOutput
extension WelcomePresenter: WelcomeInteractorOutput {
    func openRegistrationCompliteModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.openRegistrationCompliteModule()
    }
    
    func closeAuthModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.closeAuthModule()
    }
}

// MARK: - WelcomeModuleInput
extension WelcomePresenter: WelcomeModuleInput {
    func configure(output: WelcomeModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
