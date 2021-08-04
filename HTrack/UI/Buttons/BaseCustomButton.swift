//
//  BaseCustomButton.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

class BaseCustomButton: ViewWithCustomTouchArea, BaseCustomButtonActionProtocol {
    enum ButtonStatus {
        case busy
        case normal
        case deactive
    }
    
    var action: (() -> Void)?
    var needAnimationTap: Bool = true
    var buttonStatus: ButtonStatus = .normal
    
    var _startFrame: CGRect = .zero
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    func startAction() {
        action?()
    }
    
    @discardableResult
    func setButtonStatus(_ status: ButtonStatus) -> Self {
        self.buttonStatus = status
        
        return self
    }
}

extension BaseCustomButton {
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
            
            if _startFrame.hitFrame(touchAreaInsets).contains(touchLocation) {
                if needAnimationTap {
                    scaleDown()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDuarationButton) { [weak self] in
                        self?.startAction()
                        self?.scaleDown(false)
                    }
                } else {
                    startAction()
                }
            }
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self.superview)
                
                if _startFrame.hitFrame(touchAreaInsets).contains(touchLocation) {
                    scaleDown(true)
                } else {
                    scaleDown(false)
                }
            }
        }
        
        super.touchesMoved(touches, with: event)
    }
}
