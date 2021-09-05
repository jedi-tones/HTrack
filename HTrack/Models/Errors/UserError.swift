//
//  UserError.swift
//  HTrack
//
//  Created by Jedi Tones on 9/2/21.
//

import Foundation

enum UserError {
    case currentUserNotExist
    case unowned(error: String)
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .currentUserNotExist:
            return NSLocalizedString("Текущий пользователь не существует", comment: "")
        case .unowned(let error):
            return NSLocalizedString(error, comment: "")
        }
    }
}
