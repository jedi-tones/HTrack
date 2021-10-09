//
//  JSONEncoder+Extension.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import Foundation

extension JSONEncoder {
    func toObject<T:Codable>(item: T) -> Any? {
        guard
            let encodeData = try? JSONEncoder().encode(item),
            let object = try? JSONSerialization.jsonObject(with: encodeData, options: [])
            else { return [:] }
        
        return object
    }
}
