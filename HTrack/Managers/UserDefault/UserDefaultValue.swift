//
//  UserDefaultValue.swift
//  HTrack
//
//  Created by Jedi Tones on 11.11.2021.
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
