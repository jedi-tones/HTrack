//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol LoginEmailViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol LoginEmailViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol LoginEmailInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol LoginEmailInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol LoginEmailRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol LoginEmailModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: LoginEmailModuleOutput)
}

protocol LoginEmailModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
