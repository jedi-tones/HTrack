//
//  PushNotificationManager.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import UserNotifications
import UIKit
import FirebaseMessaging

class PushNotificationManager: NSObject {
    static let shared = PushNotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
        addActionCategory()
    }
    
    //MARK: requestNotificationAuth
    func requestNotificationAuth() {
        notificationCenter.requestAuthorization(options: [.alert,.badge,.sound,.announcement]) { [weak self] isGranted, error in
            
            if isGranted {
                Logger.show(title: "requestAuthorization", text: "Authorization for notification succeeded")
                self?.getNotificationSettings()
            } else {
                Logger.show(title: "requestAuthorization", text: "Authorization for notification not given.")
            }
        }
    }
    
    //MARK: getNotificationSettings
    private func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                //Attempt registration for remote notifications on the main thread
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    //MARK: scheduleNotification
    func scheduleNotification(title:String, body: String, image: UIImage? ) {
        let id = "Local notification"
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = MNotificationActionType.systemMessage.rawValue
        content.userInfo = MGradusNotification(deeplinkType: MDeeplinkType.main,
                                               title: "Test title",
                                               message: "Test message",
                                               authorID: "Test id").toDictionary() ?? [:]

        let request = UNNotificationRequest(identifier: id, content: content, trigger: triger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: addActionCategory
    private func addActionCategory() {
        let categoryName = MNotificationActionType.newRequest.rawValue
        let acceptAction = UNNotificationAction(identifier: "acceptAction",
                                                title: "Принять",
                                                options: [.authenticationRequired])

        let rejectAction = UNNotificationAction(identifier: "rejectAction",
                                                title: "Отклонить",
                                                options: [.destructive])
        
        let category = UNNotificationCategory(identifier: categoryName,
                                              actions: [acceptAction,rejectAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
}

extension PushNotificationManager: UNUserNotificationCenterDelegate {
    
    //when app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        
        if #available(iOS 14, *) {
            completionHandler([.sound, .banner])
        } else {
            completionHandler([.sound, .alert])
        }
    }
    
    //when receive
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        Logger.show(title: "userNotificationCenter", text: "didReceive userInfo \(userInfo)")
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        let data: [String : Any] = userInfo as? [String : Any] ?? [:]
        
        if let anonNotification: MGradusNotification = data.toObject() {
            Logger.show(title: "userNotificationCenter", text: "didReceive MGradusNotification \(anonNotification)")
        }
        //parse for check deeplink
        DeeplinkManager.shared.handleRemoteNotification(userInfo)
       
        /*
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("default action")
        case "snooze":
            print("snooze action")
        case "view":
            print("view action")
        case "cancel":
            print("cancel action")
        default:
            print("Unknown action")
        }
        */
        completionHandler()
    }
}
