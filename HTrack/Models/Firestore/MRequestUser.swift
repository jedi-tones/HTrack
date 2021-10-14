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
    
    init(nickname: String?, userID: String, photo: String?) {
        self.nickname = nickname
        self.userID = userID
        self.photo = photo
    }
    
    init(json: [String : Any]){
        if let nickname = json["nickname"] as? String { self.nickname = nickname } else { self.nickname = ""}
        if let userID = json["userID"] as? String { self.userID = userID } else { self.userID = ""}
        if let photo = json["photo"] as? String { self.photo = photo } else { self.photo = ""}
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        nickname = try? container.decode(String?.self, forKey: .nickname) ?? "Anonym"
        userID = try container.decode(String?.self, forKey: .userID) ?? "id"
        photo = try? container.decode(String?.self, forKey: .photo)
    }
    
    enum CodingKeys:String, CodingKey {
        case nickname
        case userID
        case photo
    }
}
