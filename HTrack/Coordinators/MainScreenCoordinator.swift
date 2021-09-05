//
//  MainScreenCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit
protocol MainScreenCoordinatorFlow {
    func open(screen: MainScreenCoordinator.Screens, animated: Bool)
    func close()
}

class MainScreenCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    var parentMainTabBar: MainTabBarCoordinatorFlow? {
        return parentCoordinator as? MainTabBarCoordinatorFlow
    }
    
    enum Screens {
        case settings
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
    func open(screen: MainScreenCoordinator.Screens, animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) screen: \(screen)")
        
        switch screen {
        case .settings:
            showProfileSettings()
        }
    }
    
    func close() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        guard let parentCoordinator = self.parentCoordinator else { return }
        parentCoordinator.childDidFinish(self)
    }
    
    
    func showProfileSettings() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
    }
}
