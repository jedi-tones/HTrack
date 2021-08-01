//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol RegisterEmailViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol RegisterEmailViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol RegisterEmailInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol RegisterEmailInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol RegisterEmailRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol RegisterEmailModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: RegisterEmailModuleOutput)
}

protocol RegisterEmailModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
