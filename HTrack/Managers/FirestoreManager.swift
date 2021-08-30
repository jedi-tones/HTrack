//
//  FirestoreManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private init() {}
    
    let firestore = Firestore.firestore()
    let authFirestoreManager = FirebaseAuthentificationService.shared
}
