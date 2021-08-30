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
    case unowned(error: String)
}

extension FirestoreError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .getDocumentDataError:
            return NSLocalizedString("Ошибка получения данных документа", comment: "")
        case .cantDecodeData:
            return NSLocalizedString("Невозможно преобразовать data в обьект", comment: "")
        case .unowned(let error):
            return NSLocalizedString(error, comment: "")
        }
    }
}
