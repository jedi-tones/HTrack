//
//  BaseEndPoint.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation
import FirebaseFirestore

enum NetworkEnvironment {
    case publicAPI
    case devAPI
}

protocol BaseEndPoint {
    var documentRef: DocumentReference { get }
}

extension BaseEndPoint{
    static var environment: NetworkEnvironment {
        #if DEBUG
        let dic = ProcessInfo.processInfo.environment
        if let forceProduction = dic["forceProd"],
           forceProduction == "true" {
            return .publicAPI
        } else {
            return .devAPI
        }
        #else
        return .publicAPI
        #endif
    }
}

extension BaseEndPoint {
    static var baseFirestorePath: String {
        switch self.environment {
        
        case .publicAPI:
            return "users"
        case .devAPI:
            return "debugUsers"
        }
    }
    
    static var baseCollectionReference: CollectionReference {
        return Firestore.firestore().collection(baseFirestorePath)
    }
}
