//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol RegisterViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol RegisterViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func saveNickname()
}


// MARK: - Interactor
protocol RegisterInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol RegisterInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol RegisterRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol RegisterModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: RegisterModuleOutput)
}

protocol RegisterModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
