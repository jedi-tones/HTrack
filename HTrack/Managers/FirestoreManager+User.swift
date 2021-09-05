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
        
        Logger.show(title: "save user userDocRef", text: "\(userDocRef.path)", withHeader: true, withFooter: true)
        
        do {
            try userDocRef.setData(from: user, completion: { error in
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
    
    func updateUser(userID: String,
                    dic:[String: Any],
                    complition: ((Result<[String : Any], Error>) -> Void)?) {
        let userDocRef = FirestoreEndPoint.user(id: userID).documentRef
        
        userDocRef.updateData(dic, completion: { error in
            if let error = error {
                complition?(.failure(error))
            } else {
                complition?(.success(dic))
            }
        })
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
        
        Logger.show(title: "getCurrentUser userDocRef", text: "\(userDocRef.path)", withHeader: true, withFooter: true)
        
        userDocRef.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentSnapshot = documentSnapshot,
                      documentSnapshot.exists {
                if let user = MUser(documentSnap: documentSnapshot) {
                    complition?(.success(user))
                } else  {
                    complition?(.failure(FirestoreError.cantDecodeData))
                }
            } else {
                complition?(.failure(FirestoreError.documentSnapshotNotExist))
            }
        }
    }
    
    func getUser(id: String, complition: ((Result<MUser, Error>) -> Void)?) {
        let userDocRef = FirestoreEndPoint.user(id: id).documentRef
        
        Logger.show(title: "getUser id: \(id) userDocRef", text: "\(userDocRef.path)", withHeader: true, withFooter: true)
        
        userDocRef.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentSnapshot = documentSnapshot,
                      documentSnapshot.exists {
                if let user = MUser(documentSnap: documentSnapshot) {
                    complition?(.success(user))
                } else  {
                    complition?(.failure(FirestoreError.cantDecodeData))
                }
            } else {
                complition?(.failure(FirestoreError.documentSnapshotNotExist))
            }
        }
    }
    
    func checkNickNameIsExists(nickname: String, complition:((Result<Bool,Error>) -> Void)?) {
        let nicknameRef = FirestoreEndPoint.nickname(name: nickname).documentRef
        
        nicknameRef.getDocument { docSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let document = docSnapshot {
                complition?(.success(document.exists))
            } else {
                complition?(.success(false))
            }
        }
    }
}
