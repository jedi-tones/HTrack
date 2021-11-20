//
//  Color+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 12.11.2021.
//

import SwiftUI
import UIKit

extension Color {
    init(uiColor: UIColor) {
        self.init(red: Double(uiColor.rgba.red),
                  green: Double(uiColor.rgba.green),
                  blue: Double(uiColor.rgba.blue),
                  opacity: Double(uiColor.rgba.alpha))
    }
}
