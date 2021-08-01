//
//  BaseCustomButtonActionProtocol.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import Foundation

protocol BaseCustomButtonActionProtocol {
    var action: (() -> Void)? { get set }
}

extension BaseCustomButtonActionProtocol {
    func startAction() {
        action?()
    }
}
