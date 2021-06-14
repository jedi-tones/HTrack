//
//  UIApplication+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import UIKit

extension UIApplication {
    static var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = shared.windows.filter { $0.isKeyWindow }.first
            statusBarHeight = window?.safeAreaInsets.top ?? window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    static func getCurrentViewController() -> UIViewController? {
        guard let rootController = shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController else { return nil }
        
        if let mainTabBarViewController = rootController as? UITabBarController {
            if mainTabBarViewController.presentedViewController != nil {
                return findPresentedViewController(vc: mainTabBarViewController)
            } else {
                return mainTabBarViewController
            }
        } else if let navController = rootController as? UINavigationController,
                  let topController = navController.topViewController {
            return findPresentedViewController(vc: topController)
        } else {
            return findPresentedViewController(vc: rootController)
        }
    }
    
    static func getRootViewController() -> UIViewController? {
        if let rootController = shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
           return rootController
       }
       return nil
    }
    
    static func getCurrentViewControllerWithNavController() -> UIViewController? {

        if let rootController = shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
           var currentController: UIViewController! = rootController
            while( currentController.navigationController != nil) {
               currentController = currentController.presentedViewController
           }
           return currentController
       }
       return nil
   }
    
    static func findPresentedViewController(vc: UIViewController) -> UIViewController {
        var viewController: UIViewController! = vc
        while( viewController.presentedViewController != nil ) {
            viewController = viewController.presentedViewController
        }
        return viewController
    }
}
