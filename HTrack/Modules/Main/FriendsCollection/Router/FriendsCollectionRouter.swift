//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsCollectionRouter: FriendsCollectionRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func showFriendDetailScreen(user: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let friendsScreenCoordinator = coordinator as? FriendsCoordinatorFlow else { return }
        
        friendsScreenCoordinator.open(screen: .friendDetail(friend: user, inputRequest: nil), animated: false)
    }
}
