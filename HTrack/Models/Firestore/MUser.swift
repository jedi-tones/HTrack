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

struct MUser: Codable, Hashable {
    var userID: String
    var name: String?
    var mail: String?
    var authType: AuthType?
    var startDate: Date?
    var fcmKey: String?
    var isAdmin: Bool?
    var isPremiumUser: Bool?
    var isActive: Bool?
    
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
        
        if let peopleID = documet["userID"] as? String { self.userID = peopleID } else { self.userID = ""}
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
       
        if let peopleID = documet["userID"] as? String { self.userID = peopleID } else { self.userID = ""}
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
    
     func mergeWithJson(json: [String : Any]) -> MUser {
        var updatedUser = self
        if let peopleID = json["userID"] as? String { updatedUser.userID = peopleID }
        if let name = json["name"] as? String { updatedUser.name = name }
        if let mail = json["mail"] as? String { updatedUser.mail = mail }
        if let authType = json["authType"] as? String {
            if let type = AuthType(rawValue: authType) {
                updatedUser.authType = type
            }
        } else {
            updatedUser.authType = AuthType.defaultAuthType()
        }
        if let startDate = json["startDate"] as? Date { updatedUser.startDate = startDate }
        if let fcmKey = json["fcmKey"] as? String { updatedUser.fcmKey = fcmKey }
        if let isAdmin = json["isAdmin"] as? Bool { updatedUser.isAdmin = isAdmin }
        if let isPremiumUser = json["isPremiumUser"] as? Bool { updatedUser.isPremiumUser = isPremiumUser }
        if let isActive = json["isActive"] as? Bool { updatedUser.isActive = isActive }
        
        return updatedUser
    }
    
    enum CodingKeys: String, CodingKey {
        case userID
        case name
        case mail
        case authType
        case startDate
        case fcmKey
        case isAdmin
        case isPremiumUser
        case isActive
    }
    
    static func emptyPeople() -> MUser {
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
