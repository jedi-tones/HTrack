//
//  FirestoreManager+Ban.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/10/21.
//

import Foundation
import FirebaseFirestoreSwift

extension FirestoreManager {
    //MARK: ban/unban
    func getBannedUsersFor(user: String, complition:((Result<[MRequestUser],Error>) -> Void)?) {
        let bannedUserCollection = FirestoreEndPoint.bannedUsers(userID: user).collectionRef
        
        bannedUserCollection?.getDocuments(completion: { docSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let document = docSnapshot {
                let bannedUsers:[MRequestUser] = document.documents.compactMap({$0.data().toObject()})
                complition?(.success(bannedUsers))
            } else {
                complition?(.success([]))
            }
        })
    }
    
    func checkIsBannedFor(userID: String, complition:((Result<Bool,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        
        let bannedUserCollection = FirestoreEndPoint.bannedUsers(userID: userID).collectionRef
        let documentRef = bannedUserCollection?.document(currentUserID)
        
        documentRef?.getDocument { docSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let document = docSnapshot {
                complition?(.success(document.exists))
            } else {
                complition?(.success(false))
            }
        }
    }
    
    func banFor(user: MRequestUser, complition:((Result<MRequestUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        
        let bannedUserCollection = FirestoreEndPoint.bannedUsers(userID: currentUserID).collectionRef
        let docPath = bannedUserCollection?.document(user.userID)
        do {
            try _ = docPath?.setData(from: user)
            complition?(.success(user))
        } catch {
            complition?(.failure(error))
        }
    }
}
