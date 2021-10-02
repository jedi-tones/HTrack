//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

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
    
    func showFriendDetailScreen(user: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let friendsScreenCoordinator = coordinator as? FriendsCoordinatorFlow else { return }
        
        friendsScreenCoordinator.open(screen: .friendDetail(friend: user), animated: false)
    }
}
