//
//  Notifier.swift
//  HTrack
//
//  Created by Jedi Tones on 8/31/21.
//

import Foundation

class Notifier<Listener> {
    var withoutListeners: Bool {
        return listeners.isEmpty()
    }
    
    private var listeners: WeakCollection<Listener>
    
    var listnersCount: Int {
        return listeners.count
    }

    init() {
        listeners = WeakCollection<Listener>()
    }
    
    func subscribe(_ listener: Listener) {
        listeners.insert(listener)
    }
    
    func unsubscribe(_ listener: Listener) {
        listeners.remove(listener)
    }
    
    func forEach(_ block: (Listener) -> Void) {
        listeners.forEach(block)
    }
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
}
