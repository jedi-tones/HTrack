//
//  PushFCMManager.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

import Foundation
import FirebaseMessaging
import Combine

class PushFCMManager: NSObject {
    static let shared = PushFCMManager()
    let notificationName = "firebaseMessageToken"
    
    var fcmTokenPublisher: AnyPublisher<String,Never> {
        _fcmTokenPublisher.eraseToAnyPublisher()
    }
    var _fcmTokenPublisher = CurrentValueSubject<String, Never>("")
    
    //for auth when post request
    private let serverKey = "AAAAG9wxVfA:APA91bFiJFRGIQbGLBP9pFFdZXVCYhicxjTizNpEgYuUCXmdn0U9WEmuxnYNhmaSSHyeKUmXORTDhj0O06hpO_jnTfDzm0H21H8fc3kv1FoZbQaZfKtJiTASChREOE39roDgQD7OlzUx"
    
    private let sendUrlString = "https://fcm.googleapis.com/fcm/send"
    private let infoUrlString = "https://iid.googleapis.com/iid/info/"
    
    //MARK: sendMessage
    private func sendMessage(token: String?,
                             topic: String?,
                             title: String,
                             body: String,
                             category: MNotificationActionType,
                             bageCount: Int,
                             sound: String,
                             isMutableContent: String,
                             data: MGradusNotification?) {
        guard let url = URL(string: sendUrlString) else { fatalError("can't cast to url")}
        
        var to = ""
        //if set token = send to token
        if let token = token {
            to = token
            //else send to topic
        } else if let topic = topic {
            to = "/topics/\(topic)"
        }
        
        let param = MFCMessage(to: to,
                               notification: MAps(title: title,
                                                  body: body,
                                                  category: category.rawValue,
                                                  badge: bageCount,
                                                  sound: sound,
                                                  mutableContent: isMutableContent),
                               data: data)
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(param)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                   // print("Data received \(jsonData)")
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    private func subscribeToTopic(topic: String) {
        Messaging.messaging().subscribe(toTopic: topic)
    }
    
    private func unSubscribeToTopic(topic: String) {
        Messaging.messaging().unsubscribe(fromTopic: topic)
    }
    
    //MARK: registerDelegate
    func registerDelegate() {
        Messaging.messaging().delegate = self
    }
    
    func updateAPNsTokenInFirebase(token: Data) {
        Messaging.messaging().apnsToken = token
    }
    
    //MARK: getToken
    func getToken() {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)")
        
        Messaging.messaging().token {[weak self] token, error in
            if let error = error {
                fatalError(error.localizedDescription)
            } else if let token = token {
                Logger.show(title: "Manager",
                            text: "\(type(of: self)) - \(#function) FCM registration token: \(String(describing: token))",
                            withHeader: true,
                            withFooter: true)
                
                //обновляем FCM токен
                self?._fcmTokenPublisher.send(token)
            }
        }
    }
    
}
//MARK: -  subscribe / unsubscribe
extension PushFCMManager {
    func subscribeMainTopic() {
        subscribeToTopic(topic: FCMTopic.allDevices.rawValue)
    }
    

    func unSubscribeMainTopic() {
        unSubscribeToTopic(topic: FCMTopic.allDevices.rawValue)
    }
}

//MARK: - send message
extension PushFCMManager {
    func sendPushMessageToToken(token: String, header: String, text: String, authorID: String?, authorName: String?, category: MNotificationActionType) {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function) to token: \(token)",
                    withHeader: true,
                    withFooter: true)
        
        let data = MGradusNotification(deeplinkType: .requests,
                                       title: header,
                                       message: text,
                                       authorID: authorID,
                                       authorName: authorName,
                                       category: category)
        
        sendMessage(token: token,
                    topic: nil,
                    title: header,
                    body: text,
                    category: category,
                    bageCount: 0,
                    sound: "default",  //"zenRequestAlert.caf"
                    isMutableContent: "true",
                    data: data)
    }
    
    func sendPushMessageToToken(token: String, gradusNotification: MGradusNotification) {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function) to token: \(token)",
                    withHeader: true,
                    withFooter: true)
        
        sendMessage(token: token,
                    topic: nil,
                    title: gradusNotification.title ?? "",
                    body: gradusNotification.message ?? "",
                    category: gradusNotification.category ?? .systemMessage,
                    bageCount: 0,
                    sound: "default",  //"zenRequestAlert.caf"
                    isMutableContent: "true",
                    data: gradusNotification)
    }
}

//MARK: - MessagingDelegate
extension PushFCMManager: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function) FCM registration token: \(String(describing: fcmToken))",
                    withHeader: true,
                    withFooter: true)
        
        guard let fcmToken = fcmToken else { return }
        _fcmTokenPublisher.send(fcmToken)
    }
}
