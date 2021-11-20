//
//  AppLifecycleManager.swift
//  HTrack
//
//  Created by Jedi Tones on 20.11.2021.
//

import UIKit
import Combine

@objc protocol AppLifecycleListener: AnyObject {
    @objc optional func didBecomeActiveNotification(notification: NSNotification)
    @objc optional func didEnterBackgroundNotification(notification: NSNotification)
    @objc optional func willEnterForegroundNotification(notification: NSNotification)
    @objc optional func willResignActiveNotification(notification: NSNotification)
    @objc optional func willTerminateNotification(notification: NSNotification)
}

class AppLifecycleManager {
    static var shared: AppLifecycleManager = AppLifecycleManager()
    
    fileprivate var notifications: [AppLifecycleStatusType] = AppLifecycleStatusType.allCases
    
    var lifecycleStatusPublisher: AnyPublisher<AppLifecycleStatusType, Never> {
        _lifecycleStatusublisher.eraseToAnyPublisher()
    }
    private let _lifecycleStatusublisher = PassthroughSubject<AppLifecycleStatusType, Never>()
    
    init() {
        addObserver(notifications)
    }
    
    deinit {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)")
        
        removeObservers()
    }
}

extension AppLifecycleManager {
    enum AppLifecycleStatusType: CaseIterable {
        case didBecomeActive //после разворота
        case didEnterBackground //при сворачивании приложения
        case willEnterForeground //при перезапуске и до didBecomeActive
        case willResignActive //когда перекрывается прила к примеру входящий вызов
        case willTerminate //приложение закрывается
        
        var selector: Selector {
            switch self {
            case .didBecomeActive:
                return #selector(AppLifecycleListener.didBecomeActiveNotification(notification:))
            case .didEnterBackground:
                return #selector(AppLifecycleListener.didEnterBackgroundNotification(notification:))
            case .willEnterForeground:
                return #selector(AppLifecycleListener.willEnterForegroundNotification(notification:))
            case .willResignActive:
                return #selector(AppLifecycleListener.willResignActiveNotification(notification:))
            case .willTerminate:
                return #selector(AppLifecycleListener.willTerminateNotification(notification:))
            }
        }
        
        var notificationName: NSNotification.Name {
            switch self {
            case .didBecomeActive:
                return UIApplication.didBecomeActiveNotification
            case .didEnterBackground:
                return UIApplication.didEnterBackgroundNotification
            case .willEnterForeground:
                return UIApplication.willEnterForegroundNotification
            case .willResignActive:
                return UIApplication.willResignActiveNotification
            case .willTerminate:
                return UIApplication.willTerminateNotification
            }
        }
    }
}

extension AppLifecycleManager {
    private func addObserver(_ appStatusNotificationsType: [AppLifecycleStatusType]) {
        appStatusNotificationsType.forEach { (appStatusNotification) in
            Logger.show(title: "Manager",
                        text: "\(type(of: self)) - \(#function)")
            
            NotificationCenter.default.addObserver(self, selector: appStatusNotification.selector, name: appStatusNotification.notificationName, object: nil)
        }
    }
    
    private func removeObservers() {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)")
        
        NotificationCenter.default.removeObserver(self)
    }
}

extension AppLifecycleManager: AppLifecycleListener {
    @objc func didBecomeActiveNotification(notification: NSNotification) {
        _lifecycleStatusublisher.send(.didBecomeActive)
    }

    @objc func didEnterBackgroundNotification(notification: NSNotification) {
        _lifecycleStatusublisher.send(.didEnterBackground)
    }

    @objc func willEnterForegroundNotification(notification: NSNotification) {
        _lifecycleStatusublisher.send(.willEnterForeground)
    }

    @objc func willResignActiveNotification(notification: NSNotification) {
        _lifecycleStatusublisher.send(.willResignActive)
    }

    @objc func willTerminateNotification(notification: NSNotification) {
        _lifecycleStatusublisher.send(.willTerminate)
    }
}
