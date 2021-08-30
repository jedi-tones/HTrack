//
//  UserRequestManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation

class UserRequestManager {
    static let shared = UserRequestManager()
    
    private init() {}
    
    let firestoreManager = FirestoreManager.shared
    
    func saveUser(user: MUser, complition: ((Result<MUser,Error>) -> Void)?) {
        firestoreManager.saveUser(user: user, complition: complition)
    }
    
    func getCurrentUser(complition: ((Result<MUser,Error>) -> Void)?) {
        firestoreManager.getCurrentUser(complition: complition)
    }
}
