//
//  DrawerView+Gesture.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

extension DrawerView {
    func setupGestureRecognizer() {
        dragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragRecognizerHandler))
        containerView.addGestureRecognizer(dragRecognizer)
    }
    
    @objc func dragRecognizerHandler(recognizer: UIPanGestureRecognizer) {
        let offset = recognizer.translation(in: containerView).y
        let velocity = recognizer.velocity(in: containerView).y
        
        switch recognizer.state {
        case .changed:
            let newHeight = max(0, min(maxDrawerPosition, drawerHeight - offset))
            dragDrawer(height: newHeight)
            recognizer.setTranslation(CGPoint.zero, in: containerView)
            
        case .ended:
            finalizeDrag(velocity: -velocity)
            
        case .cancelled:
            finalizeDrag(velocity: 0)
            
        default:
            break
        }
        
        containerView.endEditing(false)
    }
    
    func dragDrawer(height: CGFloat) {
        drawerHeight = height
        containerView.frame = CGRect(origin: CGPoint(x: 0, y: Styles.Sizes.screenSize.height-height),
                                     size: CGSize(width: Styles.Sizes.screenSize.width, height: height))
    }
    
    func finalizeDrag(velocity: CGFloat) {
        guard shouldDrag else { return }
        
        let targetHeight = drawerHeight + velocity * CGFloat(animationDuration)
        
        let topPositionIsEnabled = enabledState.contains(where: {$0 == .top})
        let midPositionIsEnabled = enabledState.contains(where: {$0 == .middle})
        let botPositionIsEnabled = enabledState.contains(where: {$0 == .bottom})
        
        if targetHeight > minDrawerPosition {
          if midPositionIsEnabled {
            if targetHeight > midDrawerPosition {
                if topPositionIsEnabled {
                    setDrawerPosition(.top) {}
                } else {
                    return
                }
            } else {
                setDrawerPosition(.middle) {}
            }
          } else {
              if topPositionIsEnabled {
                  setDrawerPosition(.top) {}
              } else {
                  return
              }
          }
        } else if botPositionIsEnabled {
            setDrawerPosition(.bottom) {}
        } else {
            setDrawerPosition(.dismissed) {}
        }
    }
}
