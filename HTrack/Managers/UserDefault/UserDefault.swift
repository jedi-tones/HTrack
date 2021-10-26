//
//  UserDefault.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

protocol UserDefaultValue {}

extension Data: UserDefaultValue {}
extension String: UserDefaultValue {}
extension Date: UserDefaultValue {}
extension Bool: UserDefaultValue {}
extension Int: UserDefaultValue {}
extension Double: UserDefaultValue {}
extension Float: UserDefaultValue {}

extension Array: UserDefaultValue where Element: UserDefaultValue {}
extension Dictionary: UserDefaultValue where Key == String, Value: UserDefaultValue {}


@propertyWrapper
struct UserDefault<T: UserDefaultValue> {
    let key: UserDefaultKey
    
    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}

