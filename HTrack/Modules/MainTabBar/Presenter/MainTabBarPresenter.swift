//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainTabBarPresenter {
    weak var output: MainTabBarModuleOutput?
    weak var view: MainTabBarViewInput!
    var router: MainTabBarRouterInput!
    var interactor: MainTabBarInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    init() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - MainTabBarViewOutput
extension MainTabBarPresenter: MainTabBarViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.getTabs()
    }
    
    func startCoordinatorsFor(navigators: [UINavigationController]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.startCoordinatorsFor(navigators: navigators)
    }
    
    func checkAuth() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor.checkAuth()
    }
}

// MARK: - MainTabBarInteractorOutput
extension MainTabBarPresenter: MainTabBarInteractorOutput {
    func setupTabs(tabs: [MainTabBarTabs]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard tabs.isNotEmpty else { return }
        view.setupTabs(tabs: tabs)
    }
    
    
    func showAuth() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showAuthModule()
    }
    
    func showCompliteRegistration() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showCompliteRegistration()
    }
}

//MARK: private methods
extension MainTabBarPresenter {
    
}

// MARK: - MainTabBarModuleInput
extension MainTabBarPresenter: MainTabBarModuleInput {
    func configure(output: MainTabBarModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
