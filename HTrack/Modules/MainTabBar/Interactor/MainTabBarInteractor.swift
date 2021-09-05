//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class MainTabBarInteractor {
    weak var output: MainTabBarInteractorOutput!
    
    private var appManager = AppManager.shared
    private var userManager = UserManager.shared
    private var authManager = FirebaseAuthManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        authManager.notifier.unsubscribe(self)
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
        
        authManager.notifier.subscribe(self)
        appManager.checkAuth {[weak self] authState in
            switch authState {
            
            case .authorized:
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) USER authorized")
                self?.checkCurrentUserProfile()
                
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
    
    func checkCurrentUserProfile() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.checkCurrentUserProfileRegistration {[weak self] result in
            switch result {
            
            case .success(let state):
                switch state {
                
                case .filled:
                    //all ok
                    return
                case .needComplite:
                    self?.output.showCompliteRegistration()
                case .notExist:
                    self?.createNewCurrentUser()
                }
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) error: \(error.localizedDescription)",
                            withHeader: true,
                            withFooter: true)
            }
        }
    }
    
    func createNewCurrentUser() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.createNewCurrentUser {[weak self] result in
            switch result {
            
            case .success(_):
                self?.output.showCompliteRegistration()
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) error: \(error.localizedDescription)",
                            withHeader: true,
                            withFooter: true)
            }
        }
    }
}
