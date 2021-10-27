//
//  Module.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import Foundation
import UIKit

protocol Module {
    associatedtype Input
    var controller: UIViewController { get set }
    init(coordinator: CoordinatorProtocol, complition: ((Input)-> Void)?)
}
