//
//  Fonts.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension Styles.Fonts  {
    static func baseNormalFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func baseBoldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func soyuzFont(size: CGFloat) -> UIFont {
        return Styles.Fonts.SoyuzGrotesk.soyuz(size: size).font
    }
    
    static var normal0: UIFont {
        baseNormalFont(size: 11)
    }
    static var normal1: UIFont {
        baseNormalFont(size: 13)
    }
    static var normal2: UIFont {
        baseNormalFont(size: 17)
    }
    static var bold0: UIFont {
        baseBoldFont(size: 11)
    }
    static var bold1: UIFont {
        baseBoldFont(size: 13)
    }
    static var bold2: UIFont {
        baseBoldFont(size: 17)
    }
    static var bold3: UIFont {
        baseBoldFont(size: 28)
    }
    static var bold4: UIFont {
        baseBoldFont(size: 144)
    }
    
    static var soyuz1: UIFont {
        soyuzFont(size: 17)
    }
    static var soyuz2: UIFont {
        soyuzFont(size: 30)
    }
    static var soyuz3: UIFont {
        soyuzFont(size: 150)
    }
}
