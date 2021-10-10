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
    case unowned
    
    init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .unowned
            return
        }
        self = AuthType(rawValue: rawValue) ?? .unowned
    }
    
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
    var drinkDays: [Date]? = []
    var reportList: [MReports]? = []
    var photo: String?
    
    init(peopleID: String,
         name: String,
         mail: String,
         authType: AuthType,
         startDate: Date,
         fcmKey: String,
         isAdmin: Bool,
         isPremiumUser: Bool,
         isActive: Bool,
         drinkDays: [Date],
         reportList: [MReports],
         photo: String) {
        
        self.userID = peopleID
        self.name = name
        self.mail = mail
        self.authType = authType
        self.startDate = startDate
        self.fcmKey = fcmKey
        self.isAdmin = isAdmin
        self.isPremiumUser = isPremiumUser
        self.isActive = isActive
        self.drinkDays = drinkDays
        self.reportList = reportList
        self.photo = photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userID = try container.decode(String.self, forKey: .userID)
        name = try? container.decode(String.self, forKey: .name)
        mail = try? container.decode(String.self, forKey: .mail)
        authType = try? container.decode(AuthType.self, forKey: .authType)
        
        let unixTime = try? container.decode(Double.self, forKey: .startDate)
        if let unixTime = unixTime {
            startDate = unixTime.fromUNIXTimestampToDate()
        } else {
            startDate = Date()
        }
        
        fcmKey = try? container.decode(String.self, forKey: .fcmKey)
        isAdmin = try? container.decode(Bool.self, forKey: .isAdmin)
        isPremiumUser = try? container.decode(Bool.self, forKey: .isPremiumUser)
        isActive = try? container.decode(Bool.self, forKey: .isActive)
        let drinkDaysUnixTimes = try? container.decode([Double].self, forKey: .drinkDays)
        
        if let drinkDaysUnixTimes = drinkDaysUnixTimes {
            drinkDays = drinkDaysUnixTimes.compactMap({$0.fromUNIXTimestampToDate()})
        } else {
            drinkDays = [startDate ?? Date()]
        }
        
        reportList = try? container.decode([MReports].self, forKey: .reportList)
        photo = try? container.decode(String.self, forKey: .photo)
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
        if let startDate = documet["startDate"] as? Double { self.startDate = startDate.fromUNIXTimestampToDate() } else { self.startDate = Date()}
        if let fcmKey = documet["fcmKey"] as? String { self.fcmKey = fcmKey } else { self.fcmKey = ""}
        if let isAdmin = documet["isAdmin"] as? Bool { self.isAdmin = isAdmin } else { self.isAdmin = false}
        if let isPremiumUser = documet["isPremiumUser"] as? Bool { self.isPremiumUser = isPremiumUser } else { self.isPremiumUser = false}
        if let isActive = documet["isActive"] as? Bool { self.isActive = isActive } else { self.isActive = true}
        if let drinkDays = documet["drinkDays"] as? [Double] { self.drinkDays = drinkDays.map({$0.fromUNIXTimestampToDate()}) } else { self.drinkDays = [startDate ?? Date()]}
        if let reportList = documet["reportList"] as? [[String : Any]] { self.reportList = reportList.compactMap({$0.toObject()}) }
        if let photo = documet["photo"] as? String { self.photo = photo } else { self.photo = ""}
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
        if let startDate = documet["startDate"] as? Double { self.startDate = startDate.fromUNIXTimestampToDate() } else { self.startDate = Date()}
        if let fcmKey = documet["fcmKey"] as? String { self.fcmKey = fcmKey } else { self.fcmKey = ""}
        if let isAdmin = documet["isAdmin"] as? Bool { self.isAdmin = isAdmin } else { self.isAdmin = false}
        if let isPremiumUser = documet["isPremiumUser"] as? Bool { self.isPremiumUser = isPremiumUser } else { self.isPremiumUser = false}
        if let isActive = documet["isActive"] as? Bool { self.isActive = isActive } else { self.isActive = true}
        if let drinkDays = documet["drinkDays"] as? [Double] { self.drinkDays = drinkDays.map({$0.fromUNIXTimestampToDate()}) } else { self.drinkDays = [startDate ?? Date()]}
        if let reportList = documet["reportList"] as? [[String : Any]] { self.reportList = reportList.compactMap({$0.toObject()}) }
        if let photo = documet["photo"] as? String { self.photo = photo } else { self.photo = ""}
    }
    
    func fromJson(json: [String : Any]) -> MUser?{
        return json.toObject()
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
        if let startDate = json["startDate"] as? Double { updatedUser.startDate = startDate.fromUNIXTimestampToDate() }
        if let fcmKey = json["fcmKey"] as? String { updatedUser.fcmKey = fcmKey }
        if let isAdmin = json["isAdmin"] as? Bool { updatedUser.isAdmin = isAdmin }
        if let isPremiumUser = json["isPremiumUser"] as? Bool { updatedUser.isPremiumUser = isPremiumUser }
        if let isActive = json["isActive"] as? Bool { updatedUser.isActive = isActive }
        if let drinkDays = json["drinkDays"] as? [Double] { updatedUser.drinkDays = drinkDays.compactMap({$0.fromUNIXTimestampToDate()}) }
        if let reportList = json["reportList"] as? [[String : Any]] { updatedUser.reportList = reportList.compactMap({$0.toObject()})}
        if let photo = json["photo"] as? String { updatedUser.photo = photo }
        
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
        case drinkDays
        case reportList
        case photo
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
                           isActive: true,
                           drinkDays: [],
                           reportList: [],
                           photo: "")
        return people
    }
}
