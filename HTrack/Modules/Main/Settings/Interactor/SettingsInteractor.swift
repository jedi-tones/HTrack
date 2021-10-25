//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutput!

    let appManager = AppManager.shared
    let userManager = UserManager.shared
    let friendsManager = FriendsManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.unsubscribe(self)
    }
}

// MARK: - SettingsInteractorInput
extension SettingsInteractor: SettingsInteractorInput {
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections: [SettingsSection] = [.settings, .control]
        output.setupSections(sections: sections)
    }
    
    func getElementsFor(section: SettingsSection) -> [SettingsElement] {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
        
        case .settings:
            return [.datePicker, .reset]
        case .control:
            return [.exit]
        case .info:
            return []
        }
    }
    
    func logOut() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        do {
           try appManager.logOut()
            output.logOutSuccess()
        } catch {
            Logger.show(title: "Module",
                        text: "\(type(of: self)) - \(#function) error LogOut: \(error)",
                        withHeader: true,
                        withFooter: true)
        }
    }
    
    func getUserData() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.notifier.subscribe(self)
        
        if let user = userManager.currentUser {
            output.updateUser(user: user)
        } else {
            userManager.getCurrentUser(complition: nil)
        }
    }
    
    func changeStartDate(to: Date) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let firUser = userManager.firUser,
              let id = firUser.email else { return }
        let unixTimeStamp = to.toUNIXTime()
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
            let friendsIds = friendsManager.friends.compactMap({$0.userID})
            friendsManager.updateStartDateInFriends(friendsIDs: friendsIds, startDay: startDate) { _ in}
        }
    }
}
