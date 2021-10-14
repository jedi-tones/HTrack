//
//  AcyncCOperation.swift
//  HTrack
//
//  Created by Jedi Tones on 10/14/21.
//

import Foundation

class AsyncCOperation: COperation {
    enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        
        fileprivate var keyPath: String { return "is" + rawValue.capitalized }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncCOperation {
    // MARK: - Operation Overrides
    override open var isAsynchronous : Bool { return true }
    override open var isExecuting : Bool { return state == .executing }
    override open var isFinished : Bool { return state == .finished }
    override open var isReady: Bool { return super.isReady && state == .ready }
    
    // MARK: - Start
    override func start() {
        Logger.show(title: "\(type(of: self))", text: " - \(#function)")
        
        guard !isCancelled else {
            finish()
            return
        }
        
        if !isExecuting {
            state = .executing
        }
        
        main()
    }
    
    // MARK: - Finish
    func finish() {
        Logger.show(title: "\(type(of: self))", text: " - \(#function)")
        
        if isExecuting {
            state = .finished
        }
    }
    
    // MARK: - Cancel
    override func cancel() {
        Logger.show(title: "\(type(of: self))", text: " - \(#function)")
        
        super.cancel()
        finish()
    }
}
