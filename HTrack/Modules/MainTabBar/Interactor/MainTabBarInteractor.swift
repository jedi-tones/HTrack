//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class MainTabBarInteractor {
    weak var output: MainTabBarInteractorOutput!
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - MainTabBarInteractorInput
extension MainTabBarInteractor: MainTabBarInteractorInput {
    func getTabs() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let tabs = MainTabBarTabs.allCases
        
        output.setupTabs(tabs: tabs)
    }
}
