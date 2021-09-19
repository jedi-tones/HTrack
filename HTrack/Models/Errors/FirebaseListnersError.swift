//
//  FriendsError.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

enum FirebaseListnersError {
    case collectionPathError
    case subscribeError
    case queryDocumentInitError
    case snapshotIsNil
}

extension FirebaseListnersError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .collectionPathError:
            return NSLocalizedString("Путь для коллекции отсутствует", comment: "")
        case .subscribeError:
            return NSLocalizedString("Не удалось подписаться на обновление коллекции", comment: "")
        case .queryDocumentInitError:
            return NSLocalizedString("Не удалось инициализировать обьект из queryDocument", comment: "")
        case .snapshotIsNil:
            return NSLocalizedString("Снапшот коллекции не существует", comment: "")
        }
    }
}
