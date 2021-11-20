//
//  MRequestUser.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation
import UIKit

struct MRequestUser: Codable, Hashable {
    var nickname: String?
    var userID: String
    var photo: String?
    var fcmKey: String?
    var requestCreateDate: Date?
    
    init(nickname: String?, userID: String, photo: String?, fcmKey: String?, createDate: Date?) {
        self.nickname = nickname
        self.userID = userID
        self.photo = photo
        self.fcmKey = fcmKey
        self.requestCreateDate = createDate
    }
    
    init(user: MUser) {
        self.nickname = user.name
        self.userID = user.userID
        self.photo = user.photo
        self.fcmKey = user.fcmKey
        self.requestCreateDate = Date()
    }
    
    init(json: [String : Any]){
        if let nickname = json["nickname"] as? String { self.nickname = nickname } else { self.nickname = ""}
        if let userID = json["userID"] as? String { self.userID = userID } else { self.userID = ""}
        if let photo = json["photo"] as? String { self.photo = photo } else { self.photo = ""}
        if let fcmKey = json["fcmKey"] as? String { self.fcmKey = fcmKey } else { self.fcmKey = ""}
        if let requestCreateDate = json["requestCreateDate"] as? Double { self.requestCreateDate = requestCreateDate.fromUNIXTimestampToDate() } else { self.requestCreateDate = Date()}
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        nickname = try? container.decode(String?.self, forKey: .nickname) ?? "Anonym"
        userID = try container.decode(String?.self, forKey: .userID) ?? "id"
        photo = try? container.decode(String?.self, forKey: .photo)
        fcmKey = try? container.decode(String?.self, forKey: .fcmKey)
        let unixTime = try? container.decode(Double.self, forKey: .requestCreateDate)
        if let unixTime = unixTime {
            requestCreateDate = unixTime.fromUNIXTimestampToDate()
        } else {
            requestCreateDate = Date()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(userID, forKey: .userID)
        try? container.encode(nickname, forKey: .nickname)
        try? container.encode(photo, forKey: .photo)
        try? container.encode(fcmKey, forKey: .fcmKey)
        if let requestCreateDate = requestCreateDate {
            let unixRequestDate = requestCreateDate.toUNIXTime()
            try? container.encode(unixRequestDate, forKey: .requestCreateDate)
        }
    }
    
    enum CodingKeys:String, CodingKey {
        case nickname
        case userID
        case photo
        case fcmKey
        case requestCreateDate
    }
}
