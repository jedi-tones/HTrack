//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol RegisterUserInfoViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol RegisterUserInfoViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol RegisterUserInfoInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol RegisterUserInfoInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol RegisterUserInfoRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol RegisterUserInfoModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: RegisterUserInfoModuleOutput)
}

protocol RegisterUserInfoModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
