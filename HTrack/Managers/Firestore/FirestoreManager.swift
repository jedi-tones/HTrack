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
    
    deinit {
        friendsListnerDelegate = nil
        inputRequestListnerDelegate = nil
        outputRequestListnerDelegate = nil
        
        friendsListner?.remove()
        inputRequestsListner?.remove()
        outputRequestsListner?.remove()
    }
    
    let firestore = Firestore.firestore()
    lazy var authFirestoreManager = FirebaseAuthManager.shared
    lazy var friendsManager = FriendsManager.shared
    lazy var userManager = UserManager.shared
    
    weak var friendsListnerDelegate: FriendsListnerDelegate?
    weak var inputRequestListnerDelegate: InputRequestListnerDelegate?
    weak var outputRequestListnerDelegate: OutputRequestListnerDelegate?
    
    var friendsListner: ListenerRegistration?
    var inputRequestsListner: ListenerRegistration?
    var outputRequestsListner: ListenerRegistration?
}
