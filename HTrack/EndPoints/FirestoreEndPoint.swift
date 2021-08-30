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
}

extension FirestoreEndPoint {
    var userRef: CollectionReference {
        FirestoreEndPoint.baseCollectionReference
    }
    
    var documentRef: DocumentReference {
        switch self {
        
        case .user(let id):
            return userRef.document(id)
        }
    }
}
