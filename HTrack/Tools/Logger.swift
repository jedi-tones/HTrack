//
//  Logger.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import Foundation

struct Logger {
    static var logEnable = true
    
    static func show(title: String?,
                     text: String,
                     withHeader: Bool = false,
                     withFooter: Bool = false) {
        guard logEnable else { return }
        
        var logString = ""
        let time =  Date().formatted("HH:mm:ss.SSS")
        
        func top() {
            if withHeader {
                logString += "------------------------------"
                logString += "\n"
            }
        }
        
        func middle() {
            if let title = title {
                logString += "[LOGGER \(title.uppercased()) \(time)]: "
            } else {
                logString += "[LOGGER \(time)]: "
            }
            
            logString += String(describing: text)
        }
        
        func bottom() {
            if withFooter {
                logString += "\n"
                logString += "------------------------------"
            }
        }
        
        top()
        middle()
        bottom()
        
        print(logString)
    }
}
