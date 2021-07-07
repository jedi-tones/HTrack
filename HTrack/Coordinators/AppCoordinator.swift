//
//  AppCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol AppCoordinatorFlow {
    func startMainCoordinator()
}

class AppCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    
    let window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    deinit {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func start(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        configureNavigator()
        startMainCoordinator()
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) - child: \(type(of: child))")
        
        if child is MainTabBarCoordinator {
            modulePresenter?.dismissPresentedModule(animated: false, completion: nil)
            window.rootViewController = nil
        }
        removeCoordinator(child)
    }
}

//MARK: AppCoordinatorFlow
extension AppCoordinator: AppCoordinatorFlow {
    func startMainCoordinator() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let mainTabBarCoordinator = MainTabBarCoordinator(window: window)
        mainTabBarCoordinator.parentCoordinator = self
        mainTabBarCoordinator.start(animated: false)
        
        addCoordinator(mainTabBarCoordinator)
    }
}


//MARK: Private methods
extension AppCoordinator {
    private func configureNavigator() {

    }
}
