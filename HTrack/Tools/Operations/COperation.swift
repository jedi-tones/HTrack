//
//  COperation.swift
//  HTrack
//
//  Created by Jedi Tones on 10/14/21.
//

import Foundation

enum ResultOperation {
    case success(_ data: Any?)
    case failure(_ errors: [Error], _ data: Any?)
}

protocol OperationBuffer {
    var input: ResultOperation? { get }
    var output: ResultOperation? { get set }
}

class COperation: Operation, OperationBuffer {
    private var _input: ResultOperation?
    var input: ResultOperation? {
        if _input != nil {
            return _input
        } else {
            return getDependency()?.output
        }
    }
    var output: ResultOperation?
    
    init(_ input: ResultOperation? = nil) {
        _input = input
        super.init()
    }
}

extension COperation {
    func previousDependency() -> (OperationBuffer?) {
        let index = dependencies.firstIndex{$0 === self}
        if let index = index, index > 0 {
            let previousDependency = dependencies[index-1]
            return previousDependency as? OperationBuffer
        }
        return nil
    }
    
    func nextDependency() -> (OperationBuffer?) {
        let index = dependencies.firstIndex{$0 === self}
        if let index = index, index < dependencies.count {
            let nextDependency = dependencies[index+1]
            return nextDependency as? OperationBuffer
        }
        return nil
    }
    
    func getDependency() -> (OperationBuffer?) {
        let getDependency = dependencies.first
        return getDependency as? OperationBuffer
    }
}
