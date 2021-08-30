//
//  MPeople.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation
import FirebaseFirestore

enum AuthType: String, Codable {
    case apple
    case mail
    
    static func defaultAuthType() -> AuthType {
        return .apple
    }
}

struct MUser: Codable {
    var userID: String
    var name: String
    var mail: String
    var authType: AuthType
    var startDate: Date
    var fcmKey: String
    var isAdmin: Bool
    var isPremiumUser: Bool
    var isActive: Bool
    
    init(peopleID: String,
         name: String,
         mail: String,
         authType: AuthType,
         startDate: Date,
         fcmKey: String,
         isAdmin: Bool,
         isPremiumUser: Bool,
         isActive: Bool) {
        
        self.userID = peopleID
        self.name = name
        self.mail = mail
        self.authType = authType
        self.startDate = startDate
        self.fcmKey = fcmKey
        self.isAdmin = isAdmin
        self.isPremiumUser = isPremiumUser
        self.isActive = isActive
    }
    
    //MARK: documentSnapshot
    // for get document from Firestore
    init?(documentSnap: DocumentSnapshot){
        guard let documet = documentSnap.data()  else { return nil }
        
        if let peopleID = documet["peopleID"] as? String { self.userID = peopleID } else { self.userID = ""}
        if let name = documet["name"] as? String { self.name = name } else { self.name = ""}
        if let mail = documet["mail"] as? String { self.mail = mail } else { self.mail = ""}
        if let authType = documet["authType"] as? String {
            if let type = AuthType(rawValue: authType) {
                self.authType = type
            } else {
                self.authType = AuthType.defaultAuthType()
            }
        } else {
            self.authType = AuthType.defaultAuthType()
        }
        if let startDate = documet["startDate"] as? Timestamp { self.startDate = startDate.dateValue() } else { self.startDate = Date()}
        if let fcmKey = documet["fcmKey"] as? String { self.fcmKey = fcmKey } else { self.fcmKey = ""}
        if let isAdmin = documet["isAdmin"] as? Bool { self.isAdmin = isAdmin } else { self.isAdmin = false}
        if let isPremiumUser = documet["isPremiumUser"] as? Bool { self.isPremiumUser = isPremiumUser } else { self.isPremiumUser = false}
        if let isActive = documet["isActive"] as? Bool { self.isActive = isActive } else { self.isActive = true}
    }
    
    //MARK: QueryDocumentSnapshot
    //for init with ListenerService
    init?(documentSnap: QueryDocumentSnapshot){
        let documet = documentSnap.data()
       
        if let peopleID = documet["peopleID"] as? String { self.userID = peopleID } else { self.userID = ""}
        if let name = documet["name"] as? String { self.name = name } else { self.name = ""}
        if let mail = documet["mail"] as? String { self.mail = mail } else { self.mail = ""}
        if let authType = documet["authType"] as? String {
            if let type = AuthType(rawValue: authType) {
                self.authType = type
            } else {
                self.authType = AuthType.defaultAuthType()
            }
        } else {
            self.authType = AuthType.defaultAuthType()
        }
        if let startDate = documet["startDate"] as? Timestamp { self.startDate = startDate.dateValue() } else { self.startDate = Date()}
        if let fcmKey = documet["fcmKey"] as? String { self.fcmKey = fcmKey } else { self.fcmKey = ""}
        if let isAdmin = documet["isAdmin"] as? Bool { self.isAdmin = isAdmin } else { self.isAdmin = false}
        if let isPremiumUser = documet["isPremiumUser"] as? Bool { self.isPremiumUser = isPremiumUser } else { self.isPremiumUser = false}
        if let isActive = documet["isActive"] as? Bool { self.isActive = isActive } else { self.isActive = true}
    }
    
    func fromJson(json: [String : Any]) -> MUser?{
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
            let people = try? JSONDecoder().decode(MUser.self, from: data)
            return people
        } else {
            return nil
        }
    }
    
    func emptyPeople() -> MUser {
        let people = MUser(peopleID: "",
                             name: "",
                             mail: "",
                             authType: AuthType.defaultAuthType(),
                             startDate: Date(),
                             fcmKey: "",
                             isAdmin: false,
                             isPremiumUser: false,
                             isActive: true)
        return people
    }
}
