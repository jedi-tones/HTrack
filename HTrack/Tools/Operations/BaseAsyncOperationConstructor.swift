//
//  BaseAcyncOperationConstructor.swift
//  HTrack
//
//  Created by Jedi Tones on 10/14/21.
//

import Foundation

class BaseAsyncOperationConstructor: AsyncCOperation {
    let opBlock: (_ input: ResultOperation?, (@escaping (ResultOperation)-> Void)) -> Void
    
    init(opBlock: @escaping (_ input: ResultOperation?, (@escaping (ResultOperation)-> Void)) -> Void) {
        self.opBlock = opBlock
    }
    override func main() {
        opBlock(input) { result in
            self.output = result
            self.finish()
        }
    }
}
