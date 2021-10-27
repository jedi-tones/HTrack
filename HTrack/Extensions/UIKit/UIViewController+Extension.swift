//
//  UIViewController+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import UIKit

extension UIViewController: Presentable {
    
}

private var tagAssociationKey: String = "UIViewControllerKey"

extension UIViewController {
    public var tag: String? {
        get {
            return objc_getAssociatedObject(self, &tagAssociationKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tagAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func addChild(view: UIView?, child: UIViewController) {
        addChild(child)
        if let customView = view {
            customView.addSubview(child.view)
        } else {
            self.view.addSubview(child.view)
        }
        
        child.didMove(toParent: self)
    }
    
    func removeFromSuperview() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
