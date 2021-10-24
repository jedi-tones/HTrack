//
//  Keyboard.swift
//  HTrack
//
//  Created by Jedi Tones on 9/8/21.
//

import UIKit

@objc protocol KeyboardNotificationsDelegate: AnyObject {
    @objc optional func keyboardWillShow(notification: NSNotification)
    @objc optional func keyboardWillHide(notification: NSNotification)
    @objc optional func keyboardDidShow(notification: NSNotification)
    @objc optional func keyboardDidHide(notification: NSNotification)
    @objc optional func keyboardWillChange(notification: NSNotification)
}

class KeyboardNotifications {
    fileprivate var notifications:  [KeyboardNotificationsType]
    fileprivate weak var delegate: KeyboardNotificationsDelegate?
    
    var isEnabled: Bool = false {
        willSet {
            if newValue {
                for notificaton in notifications {
                    addObserver(notificaton)
                }
            } else {
                removeObservers()
            }
            
        }
    }
    
    init(notifications: [KeyboardNotificationsType], delegate: KeyboardNotificationsDelegate) {
        self.notifications = notifications
        self.delegate = delegate
    }
    
    deinit {
        Logger.show(title: "Keyboard",
                    text: "\(type(of: self)) - \(#function)")
        
        if isEnabled {
            removeObservers()
        }
    }
}

extension KeyboardNotifications {
    enum KeyboardNotificationsType {
        case willShow, willHide, didShow, didHide, willChange
        
        var selector: Selector {
            switch self {
            case .willShow:
                return #selector(KeyboardNotifications.keyboardWillShow(notification:))
                
            case .willHide:
                return #selector(KeyboardNotifications.keyboardWillHide(notification:))
                
            case .didShow:
                return #selector(KeyboardNotifications.keyboardDidShow(notification:))
                
            case .didHide:
                return #selector(KeyboardNotifications.keyboardDidHide(notification:))
                
            case .willChange:
                return #selector(KeyboardNotifications.keyboardWillChange(notification:))
            }
        }
        
        var notificationName: NSNotification.Name {
            switch self {
            case .willShow:
                return UIResponder.keyboardWillShowNotification
                
            case .willHide:
                return UIResponder.keyboardWillHideNotification
                
            case .didShow:
                return UIResponder.keyboardDidShowNotification
                
            case .didHide:
                return UIResponder.keyboardDidHideNotification
                
            case .willChange:
                return UIResponder.keyboardWillChangeFrameNotification
            }
        }
    }
}

extension KeyboardNotifications {
    private func addObserver(_ keyboardNotificationsType: KeyboardNotificationsType) {
        NotificationCenter.default.addObserver(self,
                                               selector: keyboardNotificationsType.selector,
                                               name: keyboardNotificationsType.notificationName,
                                               object: nil)
        
        Logger.show(title: "Keyboard",
                    text: "\(type(of: self)) - \(#function) addObserver - \(keyboardNotificationsType.notificationName.rawValue)")
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
        Logger.show(title: "Keyboard",
                    text: "\(type(of: self)) - \(#function) remove observers")
    }
}

extension KeyboardNotifications: KeyboardNotificationsDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        delegate?.keyboardWillShow?(notification: notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        delegate?.keyboardWillHide?(notification: notification)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        delegate?.keyboardDidShow?(notification: notification)
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        delegate?.keyboardDidHide?(notification: notification)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        delegate?.keyboardWillChange?(notification: notification)
    }
}

struct KeyboardPayload {
    var animationCurve: UIView.AnimationCurve
    var animationDuration: Double
    var isLocal: Bool
    var frameBegin: CGRect
    var frameEnd: CGRect
    var animationOptions: UIView.AnimationOptions { return UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue << 16)) }
    
    init?(_ notification: NSNotification) {
//        guard notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification else { return nil }
        guard let u = notification.userInfo else { return nil }
        
        animationCurve = UIView.AnimationCurve(rawValue: u[UIWindow.keyboardAnimationCurveUserInfoKey] as! Int)!
        animationDuration = u[UIWindow.keyboardAnimationDurationUserInfoKey] as! Double
        isLocal = u[UIWindow.keyboardIsLocalUserInfoKey] as! Bool
        frameBegin = u[UIWindow.keyboardFrameBeginUserInfoKey] as! CGRect
        frameEnd = u[UIWindow.keyboardFrameEndUserInfoKey] as! CGRect
    }
}
