//
//  ContainerViewController.swift
//  HTrack
//
//  Created by Jedi Tones on 8/9/21.
//

import UIKit
import TinyConstraints

class ContainerViewContoller: UIViewController {
    var currentVC: UIViewController?
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    func transitionToViewController(viewController: UIViewController, animated: Bool = true) {
        guard viewController != currentVC else { return }
        
        currentVC?.willMove(toParent: nil)
        
        if !self.children.contains(viewController) {
            self.addChild(viewController)
        }
        
        self.addSubview(subView: viewController.view, toView: self.containerView)
        
        viewController.view.layoutIfNeeded()

        func finishTransition() {
            self.currentVC?.view.removeFromSuperview()
            //self.currentVC?.removeFromParent()
            
            viewController.didMove(toParent: self)
            
            self.currentVC = viewController
        }
        
        if animated {
            viewController.view.alpha = 0
            
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase,
                           delay: 0,
                           options: .transitionFlipFromLeft,
                           animations: {
                viewController.view.alpha = 1
                self.currentVC?.view.alpha = 0
            }) { (finished) in
                finishTransition()
            }
        } else {
            finishTransition()
        }
    }
    
    private func addSubview(subView: UIView, toView parentView: UIView) {
        self.view.layoutIfNeeded()
        parentView.addSubview(subView)
        subView.edgesToSuperview()
    }
}
