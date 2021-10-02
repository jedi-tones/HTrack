//
//  Sizes.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension Styles.Sizes  {
    static let statusBar = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    static let safeAreaInsets = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets ?? .zero
    
    static let screenSize: CGSize = UIScreen.main.bounds.size
    static let minHeightDrawerView: CGFloat = 200
    
    static let baseVInset: CGFloat = 3
    static let baseHInset: CGFloat = 5
    
    static let mediumVInset: CGFloat = 5
    static let mediumHInset: CGFloat = 8
    
    static let stadartVInset: CGFloat = 8
    static let standartHInset: CGFloat = 14
    
    static let bigVInset: CGFloat = 44
    static let bigHInset: CGFloat = 22
    
    static let baseInterItemInset: CGFloat = 16
    
    static let baseButtonInsets: UIEdgeInsets = UIEdgeInsets(top: 10,
                                                             left: 10,
                                                             bottom: 10,
                                                             right: 10)
    
    static let smallButtonHeight: CGFloat = 22
    static let baseButtonHeight: CGFloat = 44
    
    static let smallCornerRadius: CGFloat = 5
    static let baseCornerRadius: CGFloat = 20
    static let baseBorderWidth: CGFloat = 2
    
    static let baseTextFieldLeftInset: CGFloat = 10
    static let baseTextFieldRightInset: CGFloat = 10
    
    static let fontSizeBig: CGFloat = 24
    static let fontSizeBase: CGFloat = 17
    static let fontSizeMedium: CGFloat = 14
    static let fontSizeSmall: CGFloat = 11
    static let fontSizeBiggest: CGFloat = 55
    static let fontSizeMainScreen: CGFloat = 144
}
