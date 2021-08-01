//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class MainTabBarInteractor {
    weak var output: MainTabBarInteractorOutput!
    private var appManager = AppManager.shared
    
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
    
    func checkAuth() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.checkAuth {[weak self] authState in
            switch authState {
            
            case .authorized:
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) USER authorized")
                //load data
            
            case .notAuthorized:
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) USER notAuthorized")
                
                self?.output.showAuth()
            case .notAvalible:
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) USER notAvalible")
                
                self?.output.showAuth()
            }
        }
        
        
    }
}
