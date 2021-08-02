//
//  MainScreenCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit
protocol MainScreenCoordinatorFlow {
    func showWelcomeScreen(animated: Bool)
    func showProfileSettings()
    func showRegisterScreen()
}

class MainScreenCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    var parentMainTabBar: MainTabBarCoordinatorFlow? {
        return parentCoordinator as? MainTabBarCoordinatorFlow
    }
    
    init(modulePresenter: Presentable) {
        self.modulePresenter = modulePresenter
    }
    
    deinit {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func start(animated: Bool = false) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        let module = MainScreenModule(coordinator: self)
        modulePresenter?.setModules(viewControllers: [module.controller], animated: false)
        
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) - child: \(type(of: child))")
        
        if child is AuthCoordinator {
            child?.modulePresenter?.dismiss(true, completion: nil)
        }
        
        removeCoordinator(child)
    }
}

extension MainScreenCoordinator: MainScreenCoordinatorFlow {
    func showWelcomeScreen(animated: Bool = true) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let authCoordinator = AuthCoordinator()
        authCoordinator.parentCoordinator = self
        authCoordinator.start(animated: animated)
        
        addCoordinator(authCoordinator)
    }
    
    func showProfileSettings() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func showRegisterScreen() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = RegisterModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: true)
    }
}
