//
//  MainScreenCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

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
    }
}
