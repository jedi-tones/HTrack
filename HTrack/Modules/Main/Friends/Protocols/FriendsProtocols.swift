//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

// MARK: - View
protocol FriendsViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol FriendsViewOutput {
    // MARK: VIEW -> PRESENTER
    
    func viewIsReady()
}


// MARK: - Interactor
protocol FriendsInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
}

protocol FriendsInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
}


// MARK: - Router
protocol FriendsRouterInput {
    // MARK: PRESENTER -> ROUTER
}


// MARK: - Presenter (Module)
protocol FriendsModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: FriendsModuleOutput)
}

protocol FriendsModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
