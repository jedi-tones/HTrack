//
//  AppManager+ViewControllers.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import UIKit

extension AppManager {
    static func findRootVC<T>(vc: T.Type) -> T? where T: UIViewController {
        var rootVC: T? = nil
        
        UIApplication.shared.windows.forEach({ (window) in
            let rootViewController = window.rootViewController
            
            if let root = rootViewController as? T {
                rootVC = root
            }
        })
        
        return rootVC
    }
    
    static var visibleRootViewController: UIViewController? {
        guard let rootViewController = UIApplication.getRootViewController() else { return nil }
        
        if let mainTabBarViewController = rootViewController as? MainTabBarViewController {
            if mainTabBarViewController.presentedViewController != nil {
                return findPresentViewController(mainTabBarViewController)
            } else if let navigator = mainTabBarViewController.navigationController {
                return navigator.topViewController
            } else {
                return rootViewController
            }
        }
        
        return findPresentViewController(rootViewController)
    }
}


extension AppManager {
    private static func findPresentViewController(_ vc: UIViewController) -> UIViewController {
        if let presentedViewController = vc.presentedViewController {
            return findPresentViewController(presentedViewController)
        }
        
        return vc
    }
}
