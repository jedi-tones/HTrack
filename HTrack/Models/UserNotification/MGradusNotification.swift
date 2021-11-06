//
//  MGradusNotification.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

struct MGradusNotification: Codable {
    var deeplinkType: MDeeplinkType?
    var title: String?
    var message: String?
    var authorID: String?
    var authorName: String?
    var category: MNotificationActionType?
}
