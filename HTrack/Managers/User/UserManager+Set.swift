//
//  UserManager+Set.swift
//  HTrack
//
//  Created by Jedi Tones on 9/2/21.
//

import Foundation
import FirebaseAuth

extension UserManager {
    //MARK: - create new
    func createNewUser(mail: String, authType: AuthType, complition: ((Result<MUser,Error>) -> Void)?) {
        var newUser = MUser.emptyPeople()
        newUser.isAdmin = false
        newUser.isActive = true
        newUser.isPremiumUser = false
        newUser.mail = mail
        newUser.userID = mail
        newUser.authType = authType
        newUser.startDate = Date()
        
        saveUser(user: newUser) {[weak self] result in
            switch result {
            
            case .success(let mUser):
                self?.currentUser = mUser
                self?.updateUser(mUser)
                
                complition?(.success(mUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    //MARK: = create New CurrentUser
    func createNewCurrentUser(complition:((Result<MUser,Error>) -> Void)?)  {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard
            let currentUserID = firebaseAuthService.getCurrentUser()?.email
        else {
            Logger.show(title: "Module ERROR",
                        text: "\(type(of: self)) - \(#function) email not exist on current Auth user")
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        
        checkUserAuthMethods(email: currentUserID) {[weak self] result in
            switch result {
            
            case .success(let method):
                self?.createNewUser(mail: currentUserID, authType: method) {[weak self] result in
                    switch result {
                    
                    case .success(let mUser):
                        complition?(.success(mUser))
                    case .failure(let error):
                        Logger.show(title: "Module ERROR",
                                    text: "\(type(of: self)) - \(#function) \(error)")
                        complition?(.failure(error))
                    }
                }
            case .failure(let error):
                complition?(.failure(error))
                return
            }
        }
    }
    
    //MARK: - save user MUser
    func saveUser(user: MUser, complition: ((Result<MUser,Error>) -> Void)?) {
        userRequestManager.saveUser(user: user) {[weak self] result in
            switch result {
            case .success(let mUser):
                self?.currentUser = mUser
                self?.updateUser(mUser)
                
                complition?(.success(mUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    //MARK: - update user fields
    func updateUser(userID: String, dic:[MUser.CodingKeys: Any],needReturnUser: Bool = false, complition: ((Result<MUser?, Error>) -> Void)?) {
        let complitCurrentUserMerge: ((Result<[String:Any], Error>) -> Void) = {[weak self] result in
            switch result {
            
            case .success(let updatedDic):
                //if we have current user update
                if let currentUser = self?.currentUser {
                    let updatedCurrentUser = currentUser.mergeWithJson(json: updatedDic)
                    self?.currentUser = updatedCurrentUser
                    self?.updateUser(updatedCurrentUser)
                    
                    complition?(.success(updatedCurrentUser))
                } else {
                    if needReturnUser {
                        //if don't have current user
                        complition?(.failure(UserError.currentUserNotExist))
                    } else {
                        complition?(.success(nil))
                    }
                }
            case .failure(let error):
                complition?(.failure(error))
            }
        }
        
        if isCurrentUser(id: userID) {
            if let currentUser = currentUser{
                userRequestManager.updateUser(userID: currentUser.userID,
                                              dic: dic,
                                              complition: complitCurrentUserMerge)
            } else {
                getCurrentUser {[weak self] result in
                    switch result {
                    
                    case .success(let mUser):
                        self?.currentUser = mUser
                        self?.userRequestManager.updateUser(userID: mUser.userID,
                                                            dic: dic,
                                                            complition: complitCurrentUserMerge)
                    case .failure(let error):
                        complition?(.failure(error))
                    }
                }
            }
        } else { //if update another user
            userRequestManager.updateUser(userID: userID, dic: dic) {[weak self] result in
                switch result {
                
                case .success(_):
                    if needReturnUser {
                        self?.userRequestManager.getUser(id: userID, complition: { result in
                            switch result {
                            
                            case .success(let mUser):
                                complition?(.success(mUser))
                            case .failure(let error):
                                complition?(.failure(error))
                            }
                        })
                    } else {
                        complition?(.success(nil))
                    }
                case .failure(let error):
                    complition?(.failure(error))
                }
            }
        }
    }
}