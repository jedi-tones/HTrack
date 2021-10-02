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
    
    func swipeAndShow(duaration: TimeInterval = Styles.Constants.animationDuarationBase,
                      superviewHeight: CGFloat? = nil,
                      onChange: (()-> Void)?,
                      complition: (()-> Void)?) {
        
        var translationY:CGFloat = 0
        if let superviewHeight = superviewHeight {
            translationY = superviewHeight
        } else if let superviewHeight = superview?.frame.height {
            translationY = superviewHeight
        }
        
        UIView.animate(withDuration: duaration/2, delay: 0, options: .curveEaseIn) {[weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: translationY)
        } completion: {[weak self] isComplite in
            if isComplite {
                onChange?()
                
                self?.transform = CGAffineTransform(translationX: 0, y: -translationY)
                resumeViewAnimation()
            }
        }
        
        func resumeViewAnimation() {
            UIView.animate(withDuration: duaration/2, delay: 0, options: .curveEaseOut) {[weak self] in
                self?.transform = .identity
            } completion: { isComplite in
                if isComplite {
                    complition?()
                }
            }
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float, withPath: Bool = true) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        if withPath {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func setCornerRadius(radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}
