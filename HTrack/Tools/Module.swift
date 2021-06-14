//
//  Module.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import Foundation

protocol Module {
    associatedtype Input
    
    init(coordinator: CoordinatorProtocol, complition: ((Input)-> Void)?)
}
