//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AuthRouter: AuthRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func showRegisterModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let authCoordinator = coordinator as? AuthCoordinatorFlow else { return }
        
        authCoordinator.open(screen: .compliteRegistration, animated: true)
    }
    
    func showMainModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let authCoordinator = coordinator as? AuthCoordinatorFlow else { return }
        
        authCoordinator.closeAuth(animated: true)
    }
}
