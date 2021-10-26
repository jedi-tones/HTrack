//
//  MFCMessage.swift
//  HTrack
//
//  Created by Jedi Tones on 10/26/21.
//

import Foundation

struct MFCMessage: Codable {
    let to: String
    let notification: MAps
    let data: MGradusNotification?
}
