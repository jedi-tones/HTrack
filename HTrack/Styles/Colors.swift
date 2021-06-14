//
//  Colors.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

struct Colors {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor  { $0.userInterfaceStyle == .dark ? dark : light  }
    }
    
    
    static func myBackgroundColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0.8748111129, green: 0.8696112037, blue: 0.8788084388, alpha: 1), dark: #colorLiteral(red: 0.1263937652, green: 0.1256497502, blue: 0.1269704401, alpha: 1))
    }
    
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
    
    static func myLabelColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    static func myMessageColor() -> UIColor {
        
        dynamicColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    static func adminMessageColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0.431372549, green: 0.7764705882, blue: 0.7921568627, alpha: 1), dark: #colorLiteral(red: 0.431372549, green: 0.7764705882, blue: 0.7921568627, alpha: 1))
    }
    
    static func myFirstButtonColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    static func mySecondButtonColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0.9379875064, green: 0.9324114919, blue: 0.942273736, alpha: 1), dark: #colorLiteral(red: 0.2514118254, green: 0.2546254992, blue: 0.254514575, alpha: 1))
    }
    
    static func myFirstButtonLabelColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
    
    static func mySecondButtonLabelColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    static func mySecondSatColor() -> UIColor {
        dynamicColor(light: #colorLiteral(red: 0.03137254902, green: 0.5921568627, blue: 0.6156862745, alpha: 1), dark: #colorLiteral(red: 0.03137254902, green: 0.5921568627, blue: 0.6156862745, alpha: 1))
    }
}
