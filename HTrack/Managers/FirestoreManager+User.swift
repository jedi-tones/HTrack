//
//  FirestoreManager+User.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation
import FirebaseFirestoreSwift

extension FirestoreManager {
    
    func saveUser(user: MUser,
                  complition: ((Result<MUser, Error>) -> Void)?){
        
        let userDocRef = FirestoreEndPoint.user(id: user.userID).documentRef
        
        do {
            try userDocRef.setData(from: user, merge: true, completion: { error in
                if let error = error {
                    complition?(.failure(error))
                } else {
                    complition?(.success(user))
                }
            })
        } catch {
            complition?(.failure(error))
        }
    }
    
    func getCurrentUser(complition: ((Result<MUser, Error>) -> Void)?){
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        
        let userDocRef = FirestoreEndPoint.user(id: currentUserID).documentRef
        
        userDocRef.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else {
                if let user = try? documentSnapshot?.data(as: MUser.self) {
                    complition?(.success(user))
                } else {
                    complition?(.failure(FirestoreError.cantDecodeData))
                }
            }
        }
    }
}
