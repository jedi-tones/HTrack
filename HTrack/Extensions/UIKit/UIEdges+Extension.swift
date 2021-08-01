//
//  UIEdges+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top,
                            left: -left,
                            bottom: -bottom,
                            right: -right)
    }
}
