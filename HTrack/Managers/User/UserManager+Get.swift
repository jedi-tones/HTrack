//
//  UserManager+Get.swift
//  HTrack
//
//  Created by Jedi Tones on 9/2/21.
//

import Foundation
import FirebaseAuth

extension UserManager {
    func getCurrentUser(complition: ((Result<MUser,Error>) -> Void)?) {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)",
        withHeader: true,
        withFooter: true)
        
        userRequestManager.getCurrentUser {[weak self] result in
            switch result {
            
            case .success(let mUser):
                self?.currentUser = mUser
                self?.updateUser(mUser)
                self?.updateFCMToken()
                
                complition?(.success(mUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    func getUser(id: String, complition: ((Result<MUser, Error>) -> Void)?) {
        userRequestManager.getUser(id: id, complition: complition)
    }
}
