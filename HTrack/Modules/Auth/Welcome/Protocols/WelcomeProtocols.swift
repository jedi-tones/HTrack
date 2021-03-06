//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import FirebaseAuth

// MARK: - View
protocol WelcomeViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol WelcomeViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func signInWithApple()
    func signInWithEmail()
}


// MARK: - Interactor
protocol WelcomeInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func signInWithApple()
    func checkCurrentUserProfile()
}

protocol WelcomeInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func authWithAppleComplite(user: User)
    func showMainScreen()
    func showCompliteRegistration()
    func closeAuthModule()
}


// MARK: - Router
protocol WelcomeRouterInput {
    // MARK: PRESENTER -> ROUTER
    func openRegistrationCompliteModule()
    func opensSignInWithEmail()
    func closeAuthModule()
}


// MARK: - Presenter (Module)
protocol WelcomeModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: WelcomeModuleOutput)
}

protocol WelcomeModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
