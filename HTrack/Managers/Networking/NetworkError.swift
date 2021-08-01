//
//  NetworkError.swift
//  HTrack
//
//  Created by Jedi Tones on 7/10/21.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case parsingJSONFail
    case requestFail
    case incorrectURL
    case error300
    case error400
    case error500
    case unownedError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        
        case .invalidData:
            return NSLocalizedString("Ошибка получения данных", comment: "")
        case .parsingJSONFail:
            return NSLocalizedString("Ошибка JSON", comment: "")
        case .requestFail:
            return NSLocalizedString("Ошибка запроса", comment: "")
        case .incorrectURL:
            return NSLocalizedString("Некорректный URL", comment: "")
        case .error300:
            return NSLocalizedString("Ответ 300", comment: "")
        case .error400:
            return NSLocalizedString("Ответ 400", comment: "")
        case .error500:
            return NSLocalizedString("Ответ 500", comment: "")
        case .unownedError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
