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
}

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    let firebaseAuthService = FirebaseAuthentificationService.shared
    let userRequestManager = UserRequestManager.shared
    
    var firUser: User? { firebaseAuthService.getCurrentUser() }
    var currentUser: MUser?
    
    func getCurrentUser(complition: ((Result<MUser,Error>) -> Void)?) {
        userRequestManager.getCurrentUser {[weak self] result in
            switch result {
            
            case .success(let mUser):
                self?.currentUser = mUser
                complition?(.success(mUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    func saveUser(user: MUser, complition: ((Result<MUser,Error>) -> Void)?) {
        userRequestManager.saveUser(user: user, complition: complition)
    }
    
    func checkUserProfileState(user: MUser) -> UserProfileState {
        if user.name.isEmpty {
            return .needComplite
        } else {
            return .filled
        }
    }
}
