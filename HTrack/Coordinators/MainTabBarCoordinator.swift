//
//  MainCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol MainTabBarCoordinatorFlow {
    func showTab(index: Int)
    func showWelcomeScreen(animated: Bool)
    
    func startMainScreenCoordinator(modulePresenter: Presentable)
    func startFriendsCoordinator(modulePresenter: Presentable)
}

class MainTabBarCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable
    var parentCoordinator: CoordinatorProtocol?
    
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
        
        let mainTabBar = MainTabBarModule(coordinator: self)
        modulePresenter.presentModule(with: mainTabBar.controller,
                                      presentationStyle: .fullScreen,
                                      animated: animated)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) - child: \(type(of: child))")
        
    }
}

//MARK: MainCoordinatorFlow
extension MainTabBarCoordinator: MainTabBarCoordinatorFlow {
    func startMainScreenCoordinator(modulePresenter: Presentable) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func startFriendsCoordinator(modulePresenter: Presentable) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func showTab(index: Int) {
        
    }
    
    func showWelcomeScreen(animated: Bool) {
        guard let parentCoordinator = self.parentCoordinator else { return }
        parentCoordinator.childDidFinish(self)
        
        if let appCoordinatorFlow = parentCoordinator as? AppCoordinatorFlow {
            appCoordinatorFlow.startAuthCoordinator(animated: animated)
        }
    }
}
