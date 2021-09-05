//
//  SettingsSection.swift
//  HTrack
//
//  Created by Jedi Tones on 9/3/21.
//

import Foundation

enum SettingsSection: String {
    case settings = "Настройки"
    case control = "Управление"
    case info = "Информация"
}

extension SettingsSection {
     var sectionElements: [Elemets]? {
        switch self {
        
        case .settings:
            return nil
        case .control:
            return [.exit]
        case .info:
            return nil
        }
    }
    
    enum Elemets: String {
        case exit = "Выход"
    }
}
