//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsRouter: FriendsRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func showSettinsScreen() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let friendsScreenCoordinator = coordinator as? FriendsCoordinatorFlow else { return }
        
        friendsScreenCoordinator.open(screen: .settings, animated: true)
//
//        let moduleController = SettingsModule(coordinator: coordinator!).controller
//        PopUpManager.shared.showViewController(viewController: moduleController, withAnimation: true, name: "test")
    }
    
    func showAddFriendScreen() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let friendsScreenCoordinator = coordinator as? FriendsCoordinatorFlow else { return }
        
        friendsScreenCoordinator.open(screen: .addFriend, animated: false)
    }
    
    func addSubmodule(page: FriendsPage, friendsOutput: FriendsCollectionModuleOutput?, requestOutput: InputRequestsModuleOutput?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let coordinator = coordinator else { return }
        switch page {
        case .friendsCollection:
            controller?.addSubmodule(moduleType: FriendsCollectionModule.self,
                                     tag: page.controllerTag,
                                     coordinator: coordinator,
                                     complition: { input in
                guard let friendsOutput = friendsOutput else {
                    return
                }

                input.configure(output: friendsOutput)
            })
            
        case .inputRequestCollection:
            controller?.addSubmodule(moduleType: InputRequestsModule.self,
                                     tag: page.controllerTag,
                                     coordinator: coordinator,
                                     complition: { input in
                guard let requestOutput = requestOutput else {
                    return
                }

                input.configure(output: requestOutput)
            })
        }
    }
    
    func getSubmoduleController(page: FriendsPage) -> UIViewController? {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let controller = controller?.subModule(by: page.controllerTag)
        return controller
    }
}
