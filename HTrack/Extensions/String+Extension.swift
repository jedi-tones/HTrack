//
//  String+Extension.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import Foundation

extension String {
    func jsonStringToData() -> Data? {
        return  self.data(using: String.Encoding.utf8)
    }
    
    func jsonStringToObject<T: Decodable>() -> T? {
        guard let jsonData = jsonStringToData() else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: jsonData)
            return result
        } catch let jsonErr {
            Logger.show(title: "Deserializer failed:", text: "decode error \n \(jsonErr)")
            return nil
        }
    }
}
