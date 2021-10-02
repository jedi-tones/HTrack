//
//  Colors.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension Styles.Colors  {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor  { $0.userInterfaceStyle == .dark ? dark : light  }
    }
    
    //MARK: base colors
    static let black1 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let black2 = black1.withAlphaComponent(0.5)
    
    static let gray1: UIColor = .secondarySystemFill
    
    static let white1 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let white2 = white1.withAlphaComponent(0.5)
    static let white3 = #colorLiteral(red: 0.9198400378, green: 0.9143720269, blue: 0.9240432382, alpha: 1)
    
    static let red1 = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    
    static let green1 = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    
    //MARK: label
    static func myBackgroundColor() -> UIColor {
        dynamicColor(light: white1, dark: black1)
    }
    
    static func mySecondBackgroundColor() -> UIColor {
        return gray1
    }
    
    static func myShadowColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    static func myDragAccessoryColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    static func myLabelColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    static func myInvertedLabelColor() -> UIColor {
        dynamicColor(light: white1, dark: black1 )
    }
    
    static func mySecondaryLabelColor() -> UIColor {
        dynamicColor(light: black2, dark: white2)
    }
    
    static func myLabelLinkColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    static func myPlaceholderColor() -> UIColor {
        dynamicColor(light: black2, dark: white2 )
    }
    
    static func myErrorLabelColor() -> UIColor {
        return red1
    }
    
    static func myInfoLabelColor() -> UIColor {
        return green1
    }
    
    static func myActivityIndicatorColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    //MARK: first button type
    static func myFilledButtonColor() -> UIColor {
        dynamicColor(light: black1, dark: white1)
    }
    
    static func myFilledDisableButtonColor() -> UIColor {
        myFilledButtonColor().withAlphaComponent(0.5)
    }
    
    static func myFilledButtonLabelColor() -> UIColor {
        myInvertedLabelColor()
    }
    
    //MARK: second button type
    static func mySecondButtonColor() -> UIColor {
        dynamicColor(light: white2, dark: black2)
    }
    
    static func mySecondButtonLabelColor() -> UIColor {
        myInvertedLabelColor()
    }
    
    //MARK: only text button
    static func onlyTextButtonColor() -> UIColor {
        dynamicColor(light: .clear, dark: .clear)
    }
    
    static func onlyTextButtonLabelColor() -> UIColor {
        myLabelColor()
    }
    
    //MARK: tabBar badge
    static func badgeColor() -> UIColor {
        dynamicColor(light: black2, dark: white2)
    }
    

    ///not in use
    static func myGrayColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 0.3098039216, green: 0.337254902, blue: 0.3725490196, alpha: 1), dark: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
    static func myLightGrayColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 0.9379875064, green: 0.9324114919, blue: 0.942273736, alpha: 1), dark: #colorLiteral(red: 0.2514118254, green: 0.2546254992, blue: 0.254514575, alpha: 1))
    }
    
    static func mySuperLightGrayColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 0.9750242829, green: 0.9692278504, blue: 0.9794797301, alpha: 1), dark: #colorLiteral(red: 0.1639038324, green: 0.168120265, blue: 0.1680073738, alpha: 1))
    }
    
    static func myWhiteColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0.1518749893, green: 0.1509793401, blue: 0.1525681615, alpha: 1))
    }
    
}
