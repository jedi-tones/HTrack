//
//  DrawerView+ScrollViewDelegate.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

extension DrawerView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrollViewBeingDragged = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if shouldDrag {
            // Prevent deceleration
            targetContentOffset.pointee = CGPoint(x: 0, y: -contentsOffsetTop)
        }
        
        // Velocity is measured in pt/ms, finalizeDrag expects pt/s
        finalizeDrag(velocity: velocity.y * 100.0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isScrollViewBeingDragged = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentsOffsetTop = scrollView.contentInset.top
        
        let dif = headerView.frame.height + scrollView.contentOffset.y
        let a = (dif - 15)/15
        if needChangeHeaderAlpha {
            headerView.headerBlurAlpha = a
        }
        
        guard scrollView.isDragging || scrollView.isDecelerating else { return }
        
        let offset = scrollView.contentOffset.y
        let newHeight = min(maxDrawerPosition, drawerHeight + offset + contentsOffsetTop)
        
        if !shouldDrag {
            if isScrollViewBeingDragged {
                dragDrawer(height: newHeight)
            }
        } else {
            if isScrollViewBeingDragged {
                scrollView.setContentOffset(CGPoint(x: 0, y: -contentsOffsetTop), animated: false)
            }
            
            if !scrollView.isDecelerating {
                dragDrawer(height: newHeight)
            }
        }
    }
}
