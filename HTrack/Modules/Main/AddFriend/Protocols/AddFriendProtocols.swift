//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol AddFriendViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol AddFriendViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol AddFriendInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol AddFriendInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol AddFriendRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol AddFriendModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: AddFriendModuleOutput)
}

protocol AddFriendModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
