//
//  AppTrackingManager.swift
//  HTrack
//
//  Created by Jedi Tones on 21.02.2022.
//


import AdSupport
import AppTrackingTransparency

protocol AppTrackingManagerProtocol {
    @available(iOS 14, *) func status() -> ATTrackingManager.AuthorizationStatus
    @available(iOS 14, *) func requestPermission(complition: ((ATTrackingManager.AuthorizationStatus) -> Void)?)
}

@available(iOS 14, *)
class AppTrackingManager: AppTrackingManagerProtocol {
    static let shared = AppTrackingManager()
    private init() {}
    
    var needInfoPicker: Bool {
        let status = ATTrackingManager.trackingAuthorizationStatus
        
        switch status {
            
        case .notDetermined:
            return true
        case .restricted:
            return false
        case .denied:
            return false
        case .authorized:
            return false
        @unknown default:
            return false
        }
    }
    
    func status() -> ATTrackingManager.AuthorizationStatus {
        return ATTrackingManager.trackingAuthorizationStatus
    }
    
    
    func requestPermission(complition: ((ATTrackingManager.AuthorizationStatus) -> Void)?) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                // Tracking authorization dialog was shown
                // and we are authorized
                print("Authorized")
                
                // Now that we are authorized we can get the IDFA
                print(ASIdentifierManager.shared().advertisingIdentifier)
            case .denied:
                // Tracking authorization dialog was
                // shown and permission is denied
                print("Denied")
            case .notDetermined:
                // Tracking authorization dialog has not been shown
                print("Not Determined")
            case .restricted:
                print("Restricted")
            @unknown default:
                print("Unknown")
            }
            complition?(status)
        }
    }
    
    func showIDFAInfoPicker() {
        if needInfoPicker {
            
        } else {
            
        }
    }
}
