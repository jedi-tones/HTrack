//
//  BaseCell+Touches.swift
//  HTrack
//
//  Created by Jedi Tones on 9/5/21.
//

import UIKit

extension BaseCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap, touchToContent(touches) {
            scaleDown()
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            scaleDown(false)
        }
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        func action() {
            tapAction()
        }
        
        if touchToContent(touches) {
            scaleDown()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDuarationBase) { [weak self] in
                action()
                self?.scaleDown(false)
            }
        } else {
            scaleDown(false)
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap, touchToContent(touches) {
            scaleDown(true)
        } else {
            scaleDown(false)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    private func touchToContent(_ touches: Set<UITouch>) -> Bool {
        if let touch = touches.first {
            let touchLocation = touch.location(in: contentView )
            
            return contentView.frame.contains(touchLocation)
        }
        
        return false
    }
}

