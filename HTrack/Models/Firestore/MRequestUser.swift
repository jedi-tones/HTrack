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
    var userID: String?
    
    init?(json: [String : Any]){
        if let nickname = json["nickname"] as? String { self.nickname = nickname } else { self.nickname = ""}
        if let userID = json["userID"] as? String { self.userID = userID } else { self.userID = ""}
    }
    
    enum CodingKeys:String, CodingKey {
        case nickname
        case userID
    }
}
