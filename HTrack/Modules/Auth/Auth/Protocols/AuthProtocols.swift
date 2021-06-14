//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol AuthViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol AuthViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol AuthInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol AuthInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol AuthRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol AuthModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: AuthModuleOutput)
}

protocol AuthModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
