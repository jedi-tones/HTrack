//
//  COperationQueue.swift
//  HTrack
//
//  Created by Jedi Tones on 10/14/21.
//

import Foundation

class COperationQueue: OperationQueue {
    private var cooperations = [COperation]()
    
    func addOperations(operations: [COperation], complete: @escaping (ResultOperation?)->()) {
        cooperations = operations
        
        cooperations.last?.completionBlock = {
            complete(self.cooperations.last?.output)
        }
        
        for i in 0..<cooperations.count {
            if i != 0 {
                cooperations[i].addDependency(cooperations[i-1])
            }
        }
    }
    
    func start() {
        self.addOperations(cooperations, waitUntilFinished: true)
    }
}
