//
//  UserDefault.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

@propertyWrapper
struct UserDefault<T: UserDefaultValue> {
    let key: UserDefaultKey
    
    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}

