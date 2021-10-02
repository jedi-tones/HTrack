//
//  Fonts.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension Styles.Fonts  {
    static func baseNormalFont(size: CGFloat) -> UIFont {
        return AvenirFonts.avenirNextRegular(size: size).font
    }
    
    static func baseBoldFont(size: CGFloat) -> UIFont {
        return AvenirFonts.avenirNextBold(size: size).font
    }
}
