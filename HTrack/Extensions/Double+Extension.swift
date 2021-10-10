//
//  Double+Extension.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/10/21.
//

import Foundation

extension Double {
    func fromUNIXTimestampToDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}
