//
//  AuthCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol AuthCoordinatorFlow {
    func open(screen: AuthCoordinator.Screens, animated: Bool)
    func closeAuth(animated: Bool)
}

class AuthCoordinator: CoordinatorProtocol {
    enum Screens {
        case welcome
        case compliteRegistration
        case emailAuthScreen
    }
    
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
    func open(screen: Screens, animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) screen: \(screen)")
        
        switch screen {
        
        case .welcome:
            showWelcomeScreen(animated: animated)
        case .compliteRegistration:
            showCompliteRegisterScreen(animated: animated)
        case .emailAuthScreen:
            showEmailAuthScreen(animated: animated)
        }
    }
    
    func closeAuth(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        guard let parentCoordinator = self.parentCoordinator else { return }
        parentCoordinator.childDidFinish(self)
    }
    
   private func showWelcomeScreen(animated: Bool) {
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
                tabBarModulePresenter.presentModule(with: navController,
                                                    presentationStyle: .fullScreen,
                                                    animated: animated)
            } else if let presentedVC = UIApplication.getCurrentViewController() {
                presentedVC.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    private func showEmailAuthScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = AuthModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: animated)
    }
    
    private func showCompliteRegisterScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = RegisterModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: animated)
    }
}
