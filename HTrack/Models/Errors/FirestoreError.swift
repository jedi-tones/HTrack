//
//  FirestoreError.swift
//  HTrack
//
//  Created by Jedi Tones on 8/27/21.
//

import Foundation

enum FirestoreError {
    case getDocumentDataError
    case cantDecodeData
    case documentSnapshotNotExist
    case userWithNameNotExist
    case userWithIDNotExist
    case userBannedYou
    case isItYou
    case thisUserAlreadyYouFriend
    case alreadyHasOutputRequestToThisUser
    case inputRequestFromUserNotExist
    case collectionPathIncorrect
    case incorrectInputData
    case incorrectResultData
    case unownedError
}

extension FirestoreError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .getDocumentDataError:
            return NSLocalizedString("Ошибка получения данных документа", comment: "")
        case .cantDecodeData:
            return NSLocalizedString("Невозможно преобразовать data в обьект", comment: "")
        case .documentSnapshotNotExist:
            return NSLocalizedString("DocumentSnapshot не существует", comment: "")
        case .userWithNameNotExist:
            return NSLocalizedString("Пользователя с таким ником не существует", comment: "")
        case .inputRequestFromUserNotExist:
            return NSLocalizedString("Входящего запроса от данного пользователя не существует", comment: "")
        case .userWithIDNotExist:
            return NSLocalizedString("Пользователя с таким ID не существует", comment: "")
        case .userBannedYou:
            return NSLocalizedString("Пользователь тебя забанил", comment: "")
        case .isItYou:
            return NSLocalizedString("Ты не можешь добавить сам себя", comment: "")
        case .thisUserAlreadyYouFriend:
            return NSLocalizedString("Он уже твой друг", comment: "")
        case .alreadyHasOutputRequestToThisUser:
            return NSLocalizedString("Ты уже отправил запрос данному пользователю", comment: "")
        case .collectionPathIncorrect:
            return NSLocalizedString("Путь коллекции некорректный", comment: "")
        case .incorrectInputData:
            return NSLocalizedString("Некорректный входной параметр", comment: "")
        case .incorrectResultData:
            return NSLocalizedString("Некорректный тип результирующей операции", comment: "")
        case .unownedError:
            return NSLocalizedString("Неизвестая ошибка", comment: "")

        }
    }
}
