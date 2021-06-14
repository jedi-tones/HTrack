//
//  Date+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import Foundation

extension Date {
    func formatted(_ format: String = "dd/MM/yyyy HH:mm:ss ZZZ",
                   timeZone: TimeZone? = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: self)
    }
}
