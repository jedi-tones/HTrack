//
//  UserManager+Check.swift
//  HTrack
//
//  Created by Jedi Tones on 9/2/21.
//

import Foundation
import FirebaseAuth

extension UserManager {
    func checkUserProfileState(user: MUser?) -> UserProfileState {
        if let user = user {
            if let name = user.name,
               !name.isEmpty {
                return .filled
            } else {
                return .needComplite
            }
        } else {
            return .notExist
        }
    }
    
    func checkNicknameIsExist(nickname: String, complition:((Result<Bool,Error>) -> Void)?) {
        userRequestManager.checkNickNameIsExists(nickname: nickname, complition: complition)
    }
    
    func checkCurrentUserProfileRegistration(complition:((Result<UserProfileState,Error>) -> Void)?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        getCurrentUser {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let user):
                let state = self.checkUserProfileState(user: user)
                complition?(.success(state))
                
            case .failure(let error):
                Logger.show(title: "Module",
                            text: "\(type(of: self)) - \(#function) ERROR: \(error.localizedDescription)")
                //if shanpshot not exist, need create new user
                if let firestoreError = error as? FirestoreError,
                   firestoreError == FirestoreError.documentSnapshotNotExist {
                    complition?(.success(.notExist))
                }
                complition?(.failure(error))
            }
        }
    }
    
    func checkUserAuthMethods(email: String, complition:@escaping (Result<AuthType, Error>) -> Void) {
        firebaseAuthService.checkAuthMethods(email: email, complition: complition)
    }
}
