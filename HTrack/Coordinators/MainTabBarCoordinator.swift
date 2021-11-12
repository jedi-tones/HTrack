//
//  MainCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol MainTabBarCoordinatorFlow {
    func showTab(index: Int)
    
    func startMainScreenCoordinator(modulePresenter: Presentable)
    func startFriendsCoordinator(modulePresenter: Presentable)
    func startAuthCoordinator(animated: Bool, showScreen: AuthCoordinator.Screens?)
}

class MainTabBarCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    var parentAppCoordinator: AppCoordinatorFlow? {
        return parentCoordinator as? AppCoordinatorFlow
    }
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    deinit {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func start(animated: Bool = false) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let mainTabBar = MainTabBarModule(coordinator: self)
        modulePresenter = mainTabBar.controller
        window.rootViewController = mainTabBar.controller
        window.makeKeyAndVisible()
        
        if let tabBarController = modulePresenter as? MainTabBarViewController {
            tabBarController.startCheckAuth()
        }
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

//MARK: MainCoordinatorFlow
extension MainTabBarCoordinator: MainTabBarCoordinatorFlow {
    func startMainScreenCoordinator(modulePresenter: Presentable) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let coordinator = MainScreenCoordinator(modulePresenter: modulePresenter)
        coordinator.parentCoordinator = self
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func startFriendsCoordinator(modulePresenter: Presentable) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let coordinator = FriendsCoordinator(modulePresenter: modulePresenter)
        coordinator.parentCoordinator = self
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func showTab(index: Int) {
        guard let tabBar = modulePresenter as? MainTabBarViewController else { return }
        guard tabBar.viewControllers?.count ?? 0 > index else { return }
        tabBar.selectedIndex = index
    }
    
    func startAuthCoordinator(animated: Bool, showScreen: AuthCoordinator.Screens?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let authCoordinator = AuthCoordinator()
        authCoordinator.parentCoordinator = self
        authCoordinator.start(animated: animated)
        
        if let showScreen = showScreen {
            authCoordinator.open(screen: showScreen, animated: false)
        }
        
        addCoordinator(authCoordinator)
    }
}
