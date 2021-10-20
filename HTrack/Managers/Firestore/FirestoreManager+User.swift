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
        
        Logger.show(title: "Save user userDocRef",
                    text: "\(String(describing: userDocRef?.path))",
                    withHeader: true,
                    withFooter: true)
        
        do {
            try userDocRef?.setData(from: user, completion: { error in
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
        
        userDocRef?.updateData(dic, completion: { error in
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
        
        Logger.show(title: "getCurrentUser userDocRef",
                    text: "\(String(describing: userDocRef?.path))",
                    withHeader: true,
                    withFooter: true)
        
        userDocRef?.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentSnapshot = documentSnapshot,
                      documentSnapshot.exists {
                if let user: MUser = documentSnapshot.data()?.toObject() {
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
        
        Logger.show(title: "getUser id: \(id) userDocRef",
                    text: "\(String(describing: userDocRef?.path))",
                    withHeader: true,
                    withFooter: true)
        
        userDocRef?.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentSnapshot = documentSnapshot,
                      documentSnapshot.exists {
                if let user: MUser = documentSnapshot.data()?.toObject() {
                    complition?(.success(user))
                } else  {
                    complition?(.failure(FirestoreError.cantDecodeData))
                }
            } else {
                complition?(.failure(FirestoreError.userWithIDNotExist))
            }
        }
    }
    
    func getUser(nickname: String, complition: ((Result<MUser, Error>) -> Void)?) {
        guard let usersCollection = FirestoreEndPoint.users.collectionRef
        else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        
        usersCollection.whereField("name", isEqualTo: nickname).getDocuments { documentsSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentsSnapshot = documentsSnapshot {
                let users: [MUser] = documentsSnapshot.documents.compactMap({$0.data().toObject()})
                
                if let user = users.first {
                    complition?(.success(user))
                } else {
                    complition?(.failure(FirestoreError.userWithNameNotExist))
                }
            } else {
                complition?(.failure(FirestoreError.userWithNameNotExist))
            }
        }
    }
    
    func hasInputRequestFrom(userID: String, complition:((Result<MRequestUser?,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let inputRequestsCollection = FirestoreEndPoint.inputRequests(userID: currentUserID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        
        let inputRequestDocRef = inputRequestsCollection.document(userID)
        inputRequestDocRef.getDocument { documentSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let documentSnapshot = documentSnapshot,
                      documentSnapshot.exists {
                if let user: MRequestUser = documentSnapshot.data()?.toObject() {
                    complition?(.success(user))
                } else  {
                    complition?(.failure(FirestoreError.cantDecodeData))
                }
            } else {
                complition?(.failure(FirestoreError.inputRequestFromUserNotExist))
            }
        }
    }
    
    //MARK: nickname check and save
    func checkNickNameIsExists(nickname: String, complition:((Result<Bool,Error>) -> Void)?) {
        let nicknameRef = FirestoreEndPoint.nickname(name: nickname).documentRef
        
        nicknameRef?.getDocument { docSnapshot, error in
            if let error = error {
                complition?(.failure(error))
            } else if let document = docSnapshot {
                complition?(.success(document.exists))
            } else {
                complition?(.success(false))
            }
        }
    }
    
    func saveNickName(nickname: String, userID: String, complition:((Result<String,Error>) -> Void)?) {
        let nicknameRef = FirestoreEndPoint.nickname(name: nickname).documentRef
        
        let nicknameModel = MNickname(nickname: nickname, userID: userID)
        do {
           try nicknameRef?.setData(from: nicknameModel) { error in
                if let error = error {
                    complition?(.failure(error))
                } else {
                    complition?(.success(nickname))
                }
            }
        } catch {
            complition?(.failure(error))
        }
    }
}
