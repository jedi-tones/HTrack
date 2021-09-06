//
//  SettingsSection.swift
//  HTrack
//
//  Created by Jedi Tones on 9/3/21.
//

import Foundation

enum SettingsSection: String {
    case settings
    case control
    case info
    
    var title: String {
        switch self {
        case .settings:
            return "Настройки"
        case .control:
            return "Управление"
        case .info:
            return "Информация"
        }
    }
}
