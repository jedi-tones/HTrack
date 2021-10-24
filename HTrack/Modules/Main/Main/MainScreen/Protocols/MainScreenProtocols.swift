//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol MainScreenViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func update(vm: MainScreenInfoViewModel)
}

protocol MainScreenViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func drinkButtonTapped()
}

// MARK: - Interactor
protocol MainScreenInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getUser() -> MUser?
    func resetDrinkDate()
}

protocol MainScreenInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func updateUserStat(user: MUser?)
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
