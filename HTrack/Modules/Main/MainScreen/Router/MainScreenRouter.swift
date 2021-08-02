//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class MainScreenRouter: MainScreenRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func showSettinsScreen() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let mainScreenCoordinator = coordinator as? MainScreenCoordinatorFlow else { return }
        
        mainScreenCoordinator.showRegisterScreen()
    }
}
