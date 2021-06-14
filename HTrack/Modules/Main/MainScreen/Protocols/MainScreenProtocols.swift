//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol MainScreenViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol MainScreenViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol MainScreenInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol MainScreenInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol MainScreenRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol MainScreenModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: MainScreenModuleOutput)
}

protocol MainScreenModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
