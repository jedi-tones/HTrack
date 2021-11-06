//
//  UserDefaultKey.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

struct UserDefaultKey: RawRepresentable {
    let rawValue: String
}

extension UserDefaultKey: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}


extension UserDefaultKey {
    static let startDate: UserDefaultKey = "startDate"
    static let fcmKey: UserDefaultKey = "fcmKey"
}
