//
//  Fonts+SoyuzGrotesk.swift
//  HTrack
//
//  Created by Jedi Tones on 10/23/21.
//

import UIKit

extension Styles.Fonts {
    enum SoyuzGrotesk {
        case soyuz(size: CGFloat)
        
        var name: String {
            switch self {
            case .soyuz:
                return "SoyuzGrotesk-Bold"
            }
        }
        
        var font: UIFont {
            switch self {
            
            case .soyuz(let size):
                return getFont(font: self, size: size)
            }
        }
        
        private func getFont(font: Styles.Fonts.SoyuzGrotesk, size: CGFloat) -> UIFont {
            if let font = UIFont.init(name: font.name, size: size) {
                return font
            } else {
                Logger.show(title: "Fonts ERROR", text: "Unknown Font \(font.name)")
                return UIFont.systemFont(ofSize: size)
            }
        }
    }
}
