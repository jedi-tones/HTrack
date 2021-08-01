//
//  UIView+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

extension UIView {
    func scaleDown(_ active: Bool = true, scale: CGFloat = 0.95, alpha: CGFloat = 0.8) {
        let _isScale = (self.layer.transform.m11 == CATransform3DMakeScale(scale, scale, scale).m11)
        guard active != _isScale else { return }
        
        UIView.animate(withDuration: 0.3) {
            if active {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
                self.alpha = alpha
            } else {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.alpha = 1
            }
        }
    }
}
