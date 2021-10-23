//
//  Colors.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension Styles.Colors  {
    enum DaysColorsPeriod: Int {
        case first = 100
        case second = 150
        case third = 366
        
        var prevValue: Int {
            switch self {
            case .first:
                return 0
            case .second:
                return DaysColorsPeriod.first.rawValue
            case .third:
                return DaysColorsPeriod.second.rawValue
            }
        }
        
        var daysInPeriod: Int {
            return self.rawValue - prevValue
        }
    }
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor  { $0.userInterfaceStyle == .dark ? dark : light  }
    }
    
    static func progressedColor(days: Int) -> UIColor {
        func calculatePercent(period: DaysColorsPeriod, daysCount: Int, inverted: Bool = true) -> CGFloat {
            let daysFromPrevPeriod = daysCount - period.prevValue
            let onePercent: CGFloat = CGFloat(period.daysInPeriod) / 100
            let completePercent = CGFloat(daysFromPrevPeriod) / onePercent
            if inverted {
                let invertedPercent = (100 - completePercent) / 100
                return invertedPercent
            } else {
                return completePercent / 100
            }
        }
        
        switch days {
        case let dayCount where dayCount <= DaysColorsPeriod.first.rawValue:
            let percent = calculatePercent(period: .first, daysCount: days, inverted: true)
            Logger.show(title: "Percent period \(DaysColorsPeriod.first)", text: " \(percent)")
            //затемняем 2 цвет до черного
            return base2.darker(by: percent)
        case let dayCount where dayCount <= DaysColorsPeriod.second.rawValue:
            let percent = calculatePercent(period: .second, daysCount: days, inverted: false)
            Logger.show(title: "Percent period \(DaysColorsPeriod.second)", text: " \(percent)")
            //осветляем 2 цвет до белого
            return base2.lighter(by: percent)
        case let dayCount where dayCount <= DaysColorsPeriod.third.rawValue:
            let percent = calculatePercent(period: .third, daysCount: days, inverted: true)
            Logger.show(title: "Percent period \(DaysColorsPeriod.third)", text: " \(percent)")
            //осветляем 4 цвет до белого
            return base4.lighter(by: percent)
        default:
            return base4
        }
    }
    
    //MARK: base colors
    static let base1 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let base2 = #colorLiteral(red: 0.9561141133, green: 0.9579541087, blue: 0.9149253964, alpha: 1)
    static let base3 = #colorLiteral(red: 0.9925743937, green: 1, blue: 0.9658847451, alpha: 1)
    static let base4 = #colorLiteral(red: 0.9176470588, green: 0.9607843137, blue: 0.3333333333, alpha: 1)
    
    
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
}
