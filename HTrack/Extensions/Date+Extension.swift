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
    
    func toUNIXTime() -> Double {
        return self.timeIntervalSince1970
    }
    
    
    func getPluarPeriod() -> String {
        let calendar = Calendar.current
        let timePeriod = calendar.dateComponents([.second,.minute,.hour,.day,.month,.year], from: self, to: Date())
        if let year = timePeriod.year, year > 0 {
            let locString = NSLocalizedString("yearsCount", comment: "")
            return String.localizedStringWithFormat(locString, year)
            
        } else if let month = timePeriod.month, month > 0 {
            let locString = NSLocalizedString("monthCount", comment: "")
            return String.localizedStringWithFormat(locString, month)
            
        } else if let day = timePeriod.day, day > 0 {
            let locString = NSLocalizedString("daysCount", comment: "")
            return String.localizedStringWithFormat(locString, day)
            
        } else if let hour = timePeriod.hour, hour > 0 {
            let locString = NSLocalizedString("hoursCount", comment: "")
            return String.localizedStringWithFormat(locString, hour)
            
        } else if let minute = timePeriod.minute, minute > 0 {
            let locString = NSLocalizedString("minCount", comment: "")
            return String.localizedStringWithFormat(locString, minute)
            
        } else if let seconds = timePeriod.second, seconds > 0 {
            let locString = NSLocalizedString("secCount", comment: "")
            return String.localizedStringWithFormat(locString, seconds)
            
        } else {
            return "???????????? ??????"
        }
    }
    
    func getPeriod() -> String {
        let calendar = Calendar.current
        let timePeriod = calendar.dateComponents([.minute,.hour,.day,.month,.year], from: self, to: Date())
        if let year = timePeriod.year, year > 0 {
            switch year {
            case let currentYear where (year % 10 == 1) && (year != 11):
                return String("\(currentYear) ??????")
            case let currentYear where (year % 10 >= 2) && (year % 10 <= 4) && (( year < 12) || (year > 14)):
                return String("\(currentYear) ????????")
            default:
                return String("\(year) ??????")
            }
        } else if let month = timePeriod.month, month > 0 {
            switch month {
            case let currentMonth where (month % 10 == 1) && (month != 11):
                return String("\(currentMonth) ??????????")
            case let currentMonth where (month % 10 >= 2) && (month % 10 <= 4) && (( month < 12) || (month > 14)):
                return String("\(currentMonth) ????????????")
            default:
                return String("\(month) ??????????????")
            }
        } else if let day = timePeriod.day, day > 0 {
            switch day {
            case let currentDay where (day % 10 == 1) && (day != 11):
                return String("\(currentDay) ????????")
            case let currentDay where (day % 10 >= 2) && (day % 10 <= 4) && (( day < 12) || (day > 14)):
                return String("\(currentDay) ??????")
            default:
                return String("\(day) ????????")
            }
        } else if let hour = timePeriod.hour, hour > 0 {
            switch hour {
            case let currentHour where (hour % 10 == 1) && (hour != 11):
                return String("\(currentHour) ??????")
            case let currentHour where (hour % 10 >= 2) && (hour % 10 <= 4) && (( hour < 12) || (hour > 14)):
                return String("\(currentHour) ????????")
            default:
                return String("\(hour) ??????????")
            }
        } else if let minute = timePeriod.minute, minute > 0 {
            switch minute {
            case let currentMinute where (minute % 10 == 1) && (minute != 11):
                return String("\(currentMinute) ????????????")
            case let currentMinute where (minute % 10 >= 2) && (minute % 10 <= 4) && (( minute < 12) || (minute > 14)):
                return String("\(currentMinute) ????????????")
            default:
                return String("\(minute) ??????????")
            }
        } else {
            return "0 ??????????"
        }
    }
    
    func getDaysString() -> String {
        let calendar = Calendar.current
        let timePeriod = calendar.dateComponents([.day], from: self, to: Date())
        let day = timePeriod.day ?? 0
        switch day {
        case let currentDay where (day % 10 == 1) && (day != 11):
            return String("\(currentDay) ????????")
        case let currentDay where (day % 10 >= 2) && (day % 10 <= 4) && (( day < 12) || (day > 14)):
            return String("\(currentDay) ??????")
        default:
            return String("\(day) ????????")
        }
    }
    
    func getDayCount() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: Date())
        let day = components.day ?? 0
        return day
    }
    
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
}
