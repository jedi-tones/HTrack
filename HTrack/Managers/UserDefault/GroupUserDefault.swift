//
//  GroupUserDefault.swift
//  HTrack
//
//  Created by Jedi Tones on 11.11.2021.
//

import Foundation

@propertyWrapper
struct GroupUserDefault<T: UserDefaultValue> {
    let key: UserDefaultKey
    
    var wrappedValue: T? {
        get { UserDefaults.group.value(forKey: key.rawValue) as? T }
        set { UserDefaults.group.set(newValue, forKey: key.rawValue) }
    }
}
