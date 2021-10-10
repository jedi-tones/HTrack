//
//  FirestoreEndpoint.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation
import FirebaseFirestore

enum FirestoreEndPoint: BaseEndPoint {
    case user(id: String)
    case users
    case nickname(name: String)
    case friends(currentUserID: String)
    case inputRequests(currentUserID: String)
    case outputRequests(currentUserID: String)
    case bannedUsers(userID: String)
}

extension FirestoreEndPoint {
    var baseRef: CollectionReference {
        FirestoreEndPoint.baseCollectionReference
    }
    
    var documentRef: DocumentReference? {
        switch self {
        
        case .user(let id):
            return baseRef.document("users").collection("users").document(id)
            
        case .nickname(let name):
            return baseRef.document("users").collection("nicknames").document(name)
        
        default:
            return nil
        }
    }
    
    var collectionRef: CollectionReference? {
        switch self {
        case .users:
            return baseRef.document("users").collection("users")
            
        case .friends(let currentUserID):
            return baseRef.document("users").collection("users").document(currentUserID).collection("friends")
            
        case .inputRequests(let currentUserID):
            return baseRef.document("users").collection("users").document(currentUserID).collection("inRequest")
            
        case .outputRequests(let currentUserID):
            return baseRef.document("users").collection("users").document(currentUserID).collection("outRequest")
        
        case .bannedUsers(let userID):
            return baseRef.document("users").collection("users").document(userID).collection("bannedUsers")
            
        default:
            return nil
        }
    }
}
