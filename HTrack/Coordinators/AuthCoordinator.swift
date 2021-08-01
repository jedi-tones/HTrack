//
//  AuthCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol AuthCoordinatorFlow {
    func showWelcomeScreen(animated: Bool)
    func showCompliteRegisterScreen()
    func showEmailAuthScreen()
    func showMainTabBarScreen(animated: Bool)
}

class AuthCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    
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
        
        ///pop to first Welcome module
        if let navController = modulePresenter as? UINavigationController {
            if navController.viewControllers.first is WelcomeViewController {
                navController.popToRootViewController(animated: animated)
            } else { /// if don't have WelcomeModule in stack, add them
                let module = WelcomeModule(coordinator: self)
                navController.setViewControllers([module.controller], animated: animated)
            }
        } else { /// if don't have modulePresenter, create theme with navController
            let module = WelcomeModule(coordinator: self)
            let navController = UINavigationController(rootViewController: module.controller)
            navController.setupNavigationController()
            modulePresenter = navController
            
            if let tabBarModulePresenter =  parentCoordinator?.modulePresenter {
                Logger.show(title: "Coordinator presentModule",
                            text: "\(type(of: self)) - \(#function)")
                tabBarModulePresenter.presentModule(with: navController, presentationStyle: .automatic, animated: animated)
            } else if let presentedVC = UIApplication.getCurrentViewController() {
                presentedVC.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    func showEmailAuthScreen() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = AuthModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: true)
    }
    
    func showCompliteRegisterScreen() {
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
