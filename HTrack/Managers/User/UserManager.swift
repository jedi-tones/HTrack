//
//  UserManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation
import FirebaseAuth

enum UserProfileState {
    case filled
    case needComplite
    case notExist
}

protocol UserManagerListner {
    func userUpdated(user: MUser)
}

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    lazy var firebaseAuthService = FirebaseAuthManager.shared
    lazy var userRequestManager = UserRequestManager.shared
    lazy var appManager = AppManager.shared
    lazy var pushFCMManager = PushFCMManager.shared
    lazy var friendsManager = FriendsManager.shared
    lazy var widgetManager = WidgetManager.shared
    
    let notifier = Notifier<UserManagerListner>()
    
    var firUser: User? { firebaseAuthService.getCurrentUser() }
    var currentUser: MUser? 
    
    func updateUser(_ user: MUser) {
        Logger.show(title: "Current UserUpdated",
                    text: "User \(String(describing: currentUser))", withHeader: true, withFooter: true)
        
      
        widgetManager.updateUser(user)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.notifier.forEach({$0.userUpdated(user: user)})
        }
    }
    
    func isCurrentUser(id: String) -> Bool {
        if let user = firebaseAuthService.getCurrentUser(),
           let currentID = user.email {
            return currentID == id
        } else {
            return false
        }
    }
}
