//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol WelcomeViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol WelcomeViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol WelcomeInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol WelcomeInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol WelcomeRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol WelcomeModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: WelcomeModuleOutput)
}

protocol WelcomeModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
