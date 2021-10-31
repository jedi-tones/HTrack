//
//  SettingsButtons.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import Foundation

enum SettingsElement: String, Hashable {
    case datePicker
    case reset
    case exit
    
    var title: String {
        switch self {
        
        case .exit:
            return "выход"
        case .datePicker:
            return "не пью с:"
        case .reset:
            return "я выпил"
        }
    }
}
