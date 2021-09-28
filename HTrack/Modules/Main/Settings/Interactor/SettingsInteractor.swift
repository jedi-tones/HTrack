//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutput!

    var appManager = AppManager.shared
    var userManager = UserManager.shared
    
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
        
        let dic: [MUser.CodingKeys : Any ] = [.startDate : to]
        
        userManager.updateUser(userID: id,
                               dic: dic,
                               complition: nil)
    }
}
