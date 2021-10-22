//
//  FirestoreManager+Friends.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation
import FirebaseFirestoreSwift

extension FirestoreManager {
    func subscribeFriendsListner(userID: String, delegate: FriendsListnerDelegate) {
        friendsListnerDelegate = delegate
        
        guard let collectionPath = FirestoreEndPoint.friends(userID: userID).collectionRef
        else {
            delegate._friendsSubscribeError(error: .collectionPathError)
            return
        }
        
        collectionPath.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot
            else {
                delegate._friendsSubscribeError(error: .snapshotIsNil)
                return
            }
            
            snapshot.documentChanges.forEach { change in
                guard let friend = MUser(documentSnap: change.document)
                else {
                    delegate._friendsSubscribeError(error: .queryDocumentInitError)
                    return
                }
                
                switch change.type {
                
                case .added:
                    delegate._friendAdd(friend: friend)
                case .modified:
                    delegate._frindsModified(friend: friend)
                case .removed:
                    delegate._friendRemoved(friend: friend)
                }
            }
        }
    }
    
    func unsubscribeFriendsListner() {
        friendsListner?.remove()
    }
    
    func subscribeInputRequestsListner(userID: String, delegate: InputRequestListnerDelegate) {
        inputRequestListnerDelegate = delegate
        
        guard let collectionPath = FirestoreEndPoint.inputRequests(userID: userID).collectionRef
        else {
            delegate.inputRequestsSubscribeError(error: .collectionPathError)
            return
        }
        
        collectionPath.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot
            else {
                delegate.inputRequestsSubscribeError(error: .snapshotIsNil)
                return
            }
            
            snapshot.documentChanges.forEach { change in
                guard let inputRequest: MRequestUser = change.document.data().toObject()
                else {
                    delegate.inputRequestsSubscribeError(error: .queryDocumentInitError)
                    return
                }
                
                switch change.type {
                
                case .added:
                    delegate.inputRequestAdd(request: inputRequest)
                case .modified:
                    delegate.inputRequestModified(request: inputRequest)
                case .removed:
                    delegate.inputRequestRemoved(request: inputRequest)
                }
            }
        }
    }
    
    func unsubscribeInputRequestsListner() {
        inputRequestsListner?.remove()
    }
    
    func subscribeOutputRequestsListner(userID: String, delegate: OutputRequestListnerDelegate) {
        outputRequestListnerDelegate = delegate
        
        guard let collectionPath = FirestoreEndPoint.outputRequests(userID: userID).collectionRef
        else {
            delegate.outputRequestsSubscribeError(error: .collectionPathError)
            return
        }
        
        collectionPath.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot
            else {
                delegate.outputRequestsSubscribeError(error: .snapshotIsNil)
                return
            }
            
            snapshot.documentChanges.forEach { change in
                guard let inputRequest: MRequestUser = change.document.data().toObject()
                else {
                    delegate.outputRequestsSubscribeError(error: .queryDocumentInitError)
                    return
                }
                
                switch change.type {
                
                case .added:
                    delegate.outputRequestAdd(request: inputRequest)
                case .modified:
                    delegate.outputRequestModified(request: inputRequest)
                case .removed:
                    delegate.outputRequestRemoved(request: inputRequest)
                }
            }
        }
    }
    
    func unsubscribeOutputRequestsListner() {
        outputRequestsListner?.remove()
    }
}
