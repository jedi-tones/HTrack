//
//  Fonts+Avenir.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

extension Styles.Fonts {
    enum AvenirFonts {
        case avenirNextBold(size: CGFloat)
        case avenirNextRegular(size: CGFloat)
        case AvenirNextUltraLight(size: CGFloat)
        case AvenirNextHeavy(size: CGFloat)
        
        var name: String {
            switch self {
            case .avenirNextBold:
                return "AvenirNext-Bold"
            case .avenirNextRegular:
                return "AvenirNext-Regular"
            case .AvenirNextUltraLight:
                return "AvenirNext-UltraLight"
            case .AvenirNextHeavy:
                return "AvenirNext-Heavy"
            }
        }
        
        var font: UIFont {
            switch self {
            
            case .avenirNextBold(size: let size):
                return getFont(font: self, size: size)
            case .avenirNextRegular(size: let size):
                return getFont(font: self, size: size)
            case .AvenirNextUltraLight(size: let size):
                return getFont(font: self, size: size)
            case .AvenirNextHeavy(size: let size):
                return getFont(font: self, size: size)
            }
        }
        
        private func getFont(font: Styles.Fonts.AvenirFonts, size: CGFloat) -> UIFont {
            if let font = UIFont.init(name: font.name, size: size) {
                return font
            } else {
                Logger.show(title: "Fonts ERROR", text: "Unknown Font \(font.name)")
                return UIFont.systemFont(ofSize: size)
            }
        }
    }
}
