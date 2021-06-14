//
//  AppCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol AppCoordinatorFlow {
    func startMainCoordinator(animated: Bool)
    func startAuthCoordinator(animated: Bool)
}

class AppCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable
    var parentCoordinator: CoordinatorProtocol?
    
    let window: UIWindow
    
    init(window: UIWindow){
        let navController = UINavigationController()
        self.window = window
        window.rootViewController = navController
        self.modulePresenter = navController
    }
    
    deinit {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func start(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        configureNavigator()
        
        window.makeKeyAndVisible()
        
        if needShowAuth() {
            startAuthCoordinator(animated: false)
        } else {
            startMainCoordinator(animated: false)
        }
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) - child: \(type(of: child))")
        
        if child is AuthCoordinator {
            modulePresenter.setModules(viewControllers: [], animated: false)
            modulePresenter.dismissPresentedModule(animated: false, completion: nil)
        }
        
        if child is MainTabBarCoordinator {
            modulePresenter.setModules(viewControllers: [], animated: false)
            modulePresenter.dismissPresentedModule(animated: false, completion: nil)
        }
        
        removeCoordinator(child)
    }
}

//MARK: AppCoordinatorFlow
extension AppCoordinator: AppCoordinatorFlow {
    func startMainCoordinator(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let mainTabBarCoordinator = MainTabBarCoordinator(modulePresenter: modulePresenter)
        mainTabBarCoordinator.parentCoordinator = self
        mainTabBarCoordinator.start(animated: animated)
        
        childCoordinators.append(mainTabBarCoordinator)
    }
    
    func startAuthCoordinator(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let authCoordinator = AuthCoordinator(modulePresenter: modulePresenter)
        authCoordinator.parentCoordinator = self
        authCoordinator.start(animated: animated)
        
        childCoordinators.append(authCoordinator)
    }
}


//MARK: Private methods
extension AppCoordinator {
    private func needShowAuth() -> Bool {
        false
    }
    
    private func configureNavigator() {
        
    }
}
