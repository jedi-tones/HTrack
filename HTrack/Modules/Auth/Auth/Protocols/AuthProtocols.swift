//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol AuthViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setState(state: AuthViewController.AuthViewControllerState)
}

protocol AuthViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func registerEmail(email: String)
    func authWithEmail(email: String)
    func checkEmail(email: String)
}


// MARK: - Interactor
protocol AuthInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func registerEmail(email: String)
    func checkEmail(email: String)
}

protocol AuthInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setState(state: AuthViewController.AuthViewControllerState)
    func showRegisterModule()
    func showMainModule()
}


// MARK: - Router
protocol AuthRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showRegisterModule()
    func showMainModule()
}


// MARK: - Presenter (Module)
protocol AuthModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: AuthModuleOutput)
}

protocol AuthModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
