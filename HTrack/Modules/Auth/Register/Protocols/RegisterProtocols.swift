//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol RegisterViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupState(state: RegisterViewController.RegisterViewControllerState)
}

protocol RegisterViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func saveNickname(name: String)
    func checkNickName(name: String)
}


// MARK: - Interactor
protocol RegisterInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func checkNickName(name: String)
    func saveNickname(name: String)
    func setAutoCheckFullFillProfile()
}

protocol RegisterInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func nicknameState(isExist: Bool)
    func nicknameIsUpdated()
    func saveError(error: Error)
}


// MARK: - Router
protocol RegisterRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showMainScreen()
}


// MARK: - Presenter (Module)
protocol RegisterModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: RegisterModuleOutput)
}

protocol RegisterModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
