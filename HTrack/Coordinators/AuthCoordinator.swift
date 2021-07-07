//
//  AuthCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol AuthCoordinatorFlow {
    func showWelcomeScreen(animated: Bool)
    func showRegisterScreen()
    func showAuthScreen()
    func showMainTabBarScreen(animated: Bool)
}

class AuthCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    var parentAppCoordinator: AppCoordinatorFlow? {
        return parentCoordinator as? AppCoordinatorFlow
    }
    
    init(modulePresenter: Presentable) {
        self.modulePresenter = modulePresenter
        
    }
    
    deinit {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func start(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        showWelcomeScreen(animated: animated)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        removeCoordinator(child)
    }
}

extension AuthCoordinator: AuthCoordinatorFlow {
    func showWelcomeScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        if let navController = modulePresenter as? UINavigationController {
            if navController.viewControllers.first is WelcomeViewController {
                navController.popToRootViewController(animated: animated)
            } else {
                let module = WelcomeModule(coordinator: self)
                navController.setViewControllers([module.controller], animated: animated)
            }
        } else {
            let module = WelcomeModule(coordinator: self)
            modulePresenter?.presentModule(with: module.controller, presentationStyle: .fullScreen, animated: animated)
        }
    }
    
    func showAuthScreen() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = AuthModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: true)
    }
    
    func showRegisterScreen() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = RegisterModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: true)
    }
    
    func showMainTabBarScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
         
        guard let parentCoordinator = self.parentCoordinator else { return }
        parentCoordinator.childDidFinish(self)
    }
}
