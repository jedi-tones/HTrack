//
//  PushFCMManager+Messages.swift
//  HTrack
//
//  Created by Jedi Tones on 06.11.2021.
//

import Foundation
import FirebaseMessaging

extension PushFCMManager {
    /// отправка пуша о с подбадриванием
    /// - Parameters:
    ///   - token: токен получателя
    ///   - sender: отправитель пуша
    func sendReactionToFriend(token: String, sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = senderName + LocDic.pushReactionTitle
        let notification = MGradusNotification(deeplinkType: .friends,
                                               title: title,
                                               message: LocDic.pushReactionDesc,
                                               authorID: sender.userID,
                                               authorName: senderName,
                                               category: .systemMessage)
        sendPushMessageToToken(token: token, gradusNotification: notification)
    }
    
    /// отправка пуша о том что пользователь принял запрос на добовление в друзья
    /// - Parameters:
    ///   - token: токен получателя
    ///   - sender: отправитель пуша
    func sendUserAdded(to token: String, sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = "У тебя новый друг:"
        let notification = MGradusNotification(deeplinkType: .friends,
                                               title: title,
                                               message: "теперь ты можешь следить за \(senderName)",
                                               authorID: sender.userID,
                                               authorName: senderName,
                                               category: .newFriend)
        sendPushMessageToToken(token: token, gradusNotification: notification)
    }
    
    /// отправка пуша о том что пользователь имеет новый входящий запрос
    /// - Parameters:
    ///   - token: токен получателя
    ///   - sender: отправитель пуша
    func sendNewInputRequest(to token: String, sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = "Новый запрос в друзья"
        let notification = MGradusNotification(deeplinkType: .requests,
                                               title: title,
                                               message: "\(senderName) ожидает твоего решения",
                                               authorID: sender.userID,
                                               authorName: senderName,
                                               category: .newRequest)
        sendPushMessageToToken(token: token, gradusNotification: notification)
    }
    
    /// отправка пуша о том что пользователь отклонил запрос
    /// - Parameters:
    ///   - token: токен получателя
    ///   - sender: отправитель пуша
    func sendRejectRequest(to token: String, sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = "GRADUS"
        let notification = MGradusNotification(deeplinkType: .requests,
                                               title: title,
                                               message: "\(senderName) отклонил твой запрос",
                                               authorID: sender.userID,
                                               authorName: senderName,
                                               category: .newRequest)
        sendPushMessageToToken(token: token, gradusNotification: notification)
    }
    
    /// отправка пуша о том что пользователь удалил из друзей
    /// - Parameters:
    ///   - token: токен получателя
    ///   - sender: отправитель пуша
    func sendDeleteFriend(to token: String, sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = "GRADUS"
        let notification = MGradusNotification(deeplinkType: .requests,
                                               title: title,
                                               message: "\(senderName) удалил тебя из друзей :(",
                                               authorID: sender.userID,
                                               authorName: senderName,
                                               category: .newRequest)
        sendPushMessageToToken(token: token, gradusNotification: notification)
    }
    
    /// отправка пуша о том что пользователь выпил
    /// - Parameters:
    ///   - tokens: токены получателей
    ///   - sender: отправитель пуша
    func iDrink(to tokens:[String], sender: MUser) {
        guard let senderName = sender.name else { return }
        let title = "Кто то у нас сорвался..."
        
        tokens.forEach { token in
            let notification = MGradusNotification(deeplinkType: .main,
                                                   title: title,
                                                   message: "\(senderName) сегодня все же выпил.",
                                                   authorID: sender.userID,
                                                   authorName: senderName,
                                                   category: .iDrink)
            sendPushMessageToToken(token: token, gradusNotification: notification)
        }
    }
}
