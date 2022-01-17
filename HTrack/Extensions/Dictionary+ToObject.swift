//
//  Dictionary+ToObject.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func toObject<T:Decodable>() -> T? {
        guard
            let data = try? JSONSerialization.data(withJSONObject: self, options: []),
            let object = try? JSONDecoder().decode(T.self, from: data)
            else { return nil }
        
        return object
    }
}
