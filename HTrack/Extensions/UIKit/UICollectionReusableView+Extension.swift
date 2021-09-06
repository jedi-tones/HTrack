//
//  UICollectionReusableView+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
