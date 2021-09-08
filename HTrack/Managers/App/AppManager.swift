//
//  AppManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    init() {}
    
    let appleAuthService = AppleAuthService.shared
    let firebaseAuthService =  FirebaseAuthManager.shared
    let userManager = UserManager.shared
    
    var needAutoCheckProfileFullFilled = true
}
