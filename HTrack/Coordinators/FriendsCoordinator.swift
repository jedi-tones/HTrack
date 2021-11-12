//
//  FriendsCoordinator.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

protocol FriendsCoordinatorFlow {
    func open(screen: FriendsCoordinator.Screens, animated: Bool)
    func close()
}

class FriendsCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    var modulePresenter: Presentable?
    var parentCoordinator: CoordinatorProtocol?
    var parentMainTabBar: MainTabBarCoordinatorFlow? {
        return parentCoordinator as? MainTabBarCoordinatorFlow
    }
    
    enum Screens {
        case friends
        case settings
        case addFriend
        case friendDetail(friend: MUser?, inputRequest: MRequestUser?)
        case mainCountScreen
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
        
        let module = FriendsModule(coordinator: self)
        modulePresenter?.setModules(viewControllers: [module.controller], animated: false)
    }
    
    func childDidFinish(_ child: CoordinatorProtocol?) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) - child: \(type(of: child))")
    }
}

extension FriendsCoordinator: FriendsCoordinatorFlow {
    func open(screen: FriendsCoordinator.Screens, animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function) screen: \(screen)")
        
        switch screen {
        
        case .friends:
            showMainScreen(animated: animated)
        case .settings:
            showProfileSettings(animated: animated)
        case .addFriend:
            showAddFriendScreen(animated: animated)
        case .friendDetail(let friend, let inputRequest):
            showFriendDetailScreen(friend: friend,
                                   inputRequest: inputRequest,
                                   animated: animated)
        case .mainCountScreen:
            showMainCountScreen(animated: animated)

        }
    }
    
    func close() {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        guard let parentCoordinator = self.parentCoordinator else { return }
        parentCoordinator.childDidFinish(self)
    }
    
    func showMainScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        ///pop to first MainScreenViewController module
        if let navController = modulePresenter as? UINavigationController {
            if navController.viewControllers.first is FriendsViewController {
                navController.popToRootViewController(animated: animated)
            } else { /// if don't have MainScreenModule in stack, add them
                let module = FriendsModule(coordinator: self)
                navController.setViewControllers([module.controller], animated: animated)
            }
        }
    }
    
    func showMainCountScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        showMainScreen(animated: animated)
        parentMainTabBar?.showTab(index: 0)
    }
    
    func showProfileSettings(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = SettingsModule(coordinator: self)
        modulePresenter?.pushModule(with: module.controller, animated: animated)
    }
    
    func showAddFriendScreen(animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = AddFriendModule(coordinator: self, complition: nil)
        modulePresenter?.presentModule(with: module.controller,
                                       presentationStyle: .overFullScreen,
                                       animated: animated)
    }
    
    func showFriendDetailScreen(friend: MUser?, inputRequest: MRequestUser?, animated: Bool) {
        Logger.show(title: "Coordinator",
                    text: "\(type(of: self)) - \(#function)")
        
        let module = FriendDetailModule(coordinator: self) { input in
            if let friend = friend {
                input.configure(friend: friend)
            } else if let inputRequest = inputRequest {
                input.configure(request: inputRequest)
            }
        }
        modulePresenter?.presentModule(with: module.controller,
                                       presentationStyle: .overFullScreen,
                                       animated: animated)
    }
}
