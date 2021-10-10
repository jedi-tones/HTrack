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
        case .userWithIDNotExist:
            return NSLocalizedString("Пользователя с таким ID не существует", comment: "")

        }
    }
}
