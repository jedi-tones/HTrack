//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class InputRequestsRouter: InputRequestsRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func showInputRequestDetailScreen(inputRequest: MRequestUser) {
        guard let friendsScreenCoordinator = coordinator as? FriendsCoordinatorFlow else { return }
        
        friendsScreenCoordinator.open(screen: .friendDetail(friend: nil, inputRequest: inputRequest), animated: false)
    }
}
