//
//  MAps.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

struct MAps: Codable {
    let title: String
    let body: String
    let category: String
    let badge: Int
    let sound: String
    let mutableContent: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case category = "click_action"
        case badge
        case sound
        case mutableContent = "mutable_content"
    }
}
