//
//  ValidatorRegex.swift
//  HTrack
//
//  Created by Денис Щиголев on 8/4/21.
//

import Foundation

enum ValidatorRegex {
    case password
    case nickname
    case email
    
    var description: String {
        switch self {
        case .password:
            return "Допустимая длина пароля 6 - 20 символов"
        case .nickname:
            return "Имя должно быть длиной от 4 до 20 символов.\nДопустимые символы: а-я А-Я a-z A-Z 0-9 - . _"
        case .email:
            return "Не похоже на Email, проверь корректность ввода"
        }
    }
    
    var regex: String {
        switch self {
        case .password:
            return "^(?=.*[a-z]).{6,20}$" // 6-20 simbols
        case .nickname:
            return "^[a-zA-Zа-яА-Я0-9-._]{4,20}$" // 2-64 а-я А-Я a-z A-Z 0-9 - . _ simbols
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}" // email
        }
    }
}
