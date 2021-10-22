//
//  UIButtonWithHitTestInset.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

class UIButtonWithHitTestInset: UIButton {
    var hitTestInset: UIEdgeInsets = .zero
    var needAnimationTap: Bool = true
    var startAction: (()->Void)?
    private var _startFrame: CGRect = .zero

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestInset != .zero {
            let rect = bounds.inset(by: hitTestInset.inverted())
            return rect.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }
}

extension UIButtonWithHitTestInset {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            scaleDown()
        }
        
        _startFrame = self.frame
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            scaleDown(false)
        }
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self.superview)
            
            if _startFrame.hitFrame(hitTestInset).contains(touchLocation) {
                if needAnimationTap {
                    scaleDown()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDuarationButton) { [weak self] in
                        self?.startAction?()
                        self?.scaleDown(false)
                    }
                } else {
                    startAction?()
                }
            }
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self.superview)
                
                if _startFrame.hitFrame(hitTestInset).contains(touchLocation) {
                    scaleDown(true)
                } else {
                    scaleDown(false)
                }
            }
        }
        
        super.touchesMoved(touches, with: event)
    }
}
