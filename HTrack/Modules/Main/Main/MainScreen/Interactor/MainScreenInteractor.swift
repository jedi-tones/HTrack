//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import Combine

class MainScreenInteractor {
    weak var output: MainScreenInteractorOutput!

    let userManager = UserManager.shared
    let friendsManager = FriendsManager.shared
    let authManager = FirebaseAuthManager.shared
    let appManager = AppManager.shared
    let widgetManager = WidgetManager.shared
    let appTrackingManager = AppTrackingManager.shared
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        subscribeAppStatePublisher()
    }
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.unsubscribe(self)
        authManager.notifier.unsubscribe(self)
    }
    
    private func subscribeAppStatePublisher() {
        appManager.appLifecycleManager.lifecycleStatusPublisher
            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)
            .sink {[weak self] lifeCycleState in
                switch lifeCycleState {
                case .didBecomeActive:
                    self?.output.needUpdateDate()
                    self?.widgetManager.updateWidget()
                default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    func getUser() -> MUser? {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.subscribe(self)
        authManager.notifier.subscribe(self)
        
        if let user = userManager.currentUser {
            return user
        } else {
            return nil
        }
    }
    
    func requestAppTrackingPermission() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appTrackingManager.requestPermission(complition: nil)
    }
    
    func resetDrinkDate() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let firUser = userManager.firUser,
              let id = firUser.email else { return }
        let unixTimeStamp = Date().toUNIXTime()
        let dic: [MUser.CodingKeys : Any ] = [.startDate : unixTimeStamp]
        
        userManager.updateUser(userID: id,
                               dic: dic) { result in
            switch result {
                
            case .success(_):
                updateStartDateOnFriends(startDate: unixTimeStamp)
            case .failure(_):
                break
            }
        }
        
        func updateStartDateOnFriends(startDate: Double) {
            Logger.show(title: "Module",
                        text: "\(type(of: self)) - \(#function)")
            
            friendsManager.updateStartDateInFriends(startDay: startDate) { _ in}
        }
    }
}
