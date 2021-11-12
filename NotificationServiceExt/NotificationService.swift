//
//  NotificationService.swift
//  NotificationServiceExt
//
//  Created by Jedi Tones on 11.11.2021.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    var settingsManager = NotificationServiceSettingsManager.shared
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            if let badgeCount = bestAttemptContent.badge as? Int {
                switch badgeCount {
                case 0:
                    settingsManager.badgeCount = 0
                    bestAttemptContent.badge = 0
                default:
                    let currentBadgeCount = settingsManager.badgeCount ?? 0
                    let newBadgeCount = currentBadgeCount + badgeCount
                    
                    settingsManager.badgeCount = newBadgeCount
                    bestAttemptContent.badge = NSNumber(value: newBadgeCount)
                }
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
