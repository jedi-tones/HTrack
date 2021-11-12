//
//  Sizes+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 12.11.2021.
//

import UIKit

extension Styles.Sizes {
    static let statusBar = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    static let safeAreaInsets = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets ?? .zero
}
