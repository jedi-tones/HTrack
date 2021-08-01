//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainTabBarRouter: MainTabBarRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func startCoordinatorsFor(navigators: [UINavigationController]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let coordinator = coordinator as? MainTabBarCoordinatorFlow
        else {
            Logger.show(title: "Module ERROR",
                        text: "\(type(of: self)) - \(#function) - coordinator is nil")
            return
        }
        
        navigators.forEach { navigator in
            switch navigator.tabBarItem.tag {
            case MainTabBarTabs.main.tag:
                coordinator.startMainScreenCoordinator(modulePresenter: navigator)
            case MainTabBarTabs.friends.tag:
                coordinator.startFriendsCoordinator(modulePresenter: navigator)
            default:
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) - unknow tag \(navigator.tabBarItem.tag)")
                break
            }
        }
    }
    
    func showAuthModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let coordinator = coordinator as? MainTabBarCoordinatorFlow
        else {
            Logger.show(title: "Module ERROR",
                        text: "\(type(of: self)) - \(#function) - coordinator is nil")
            return
        }
        
        coordinator.startAuthCoordinator(animated: true)
    }
}
