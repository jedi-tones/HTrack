//
//  AuthError.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation

enum AuthError {
    case userError
    case userEmailNil
    case appleIDSignInError
    case notFilled
    case invalidEmail
    case invalidPassword
    case passwordNotMatch
    case unknowError
    case serverError
    case appleToken
    case serializeAppleToken
    case missingEmail
    case credentialError
    case authTypeEpmty
    case authTypeUnowned(types: [String])
    case unowned(error: String)
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .userError:
            return NSLocalizedString("Ошибка получения данных пользователя", comment: "")
        case .userEmailNil:
            return NSLocalizedString("Email пользователя отсутствует", comment: "")
        case .appleIDSignInError:
            return NSLocalizedString("Ошибка входа Apple ID", comment: "")
        case .notFilled:
            return NSLocalizedString("Заполни все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Некорректно введен Email", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Некорректно введен пароль", comment: "")
        case .passwordNotMatch:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknowError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        case .appleToken:
            return NSLocalizedString("Невозможно поолучить токен Apple", comment: "")
        case .serializeAppleToken:
            return NSLocalizedString("Невозможно выполнить сериализацию токена Apple", comment: "")
        case .missingEmail:
            return NSLocalizedString("Отсутствует Email у пользователя", comment: "")
        case .credentialError:
            return NSLocalizedString("Не удалось получить данные авторизации", comment: "")
        case .authTypeEpmty:
            return NSLocalizedString("Типы авторизации пользователя не найдены", comment: "")
        case .authTypeUnowned(let types):
            return NSLocalizedString("Неизвестные типы авторизации \(types)", comment: "")
        case .unowned(let error):
            return NSLocalizedString(error, comment: "")
        }
    }
}

