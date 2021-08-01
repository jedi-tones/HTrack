//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

// MARK: - View
protocol MainTabBarViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupTabs(tabs: [MainTabBarTabs])
}

protocol MainTabBarViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func startCoordinatorsFor(navigators: [UINavigationController])
    func checkAuth()
}


// MARK: - Interactor
protocol MainTabBarInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getTabs()
    func checkAuth()
}

protocol MainTabBarInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupTabs(tabs: [MainTabBarTabs])
    func showAuth()
}


// MARK: - Router
protocol MainTabBarRouterInput {
    // MARK: PRESENTER -> ROUTER
    func startCoordinatorsFor(navigators: [UINavigationController])
    func showAuthModule()
}


// MARK: - Presenter (Module)
protocol MainTabBarModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: MainTabBarModuleOutput)
}

protocol MainTabBarModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
