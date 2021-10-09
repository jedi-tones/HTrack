//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AddFriendInteractor {
    weak var output: AddFriendInteractorOutput?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - AddFriendInteractorInput
extension AddFriendInteractor: AddFriendInteractorInput {
    func addDataListnerFor(section: OutputRequestSection) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        
    }
    
    func sendAddFriendAction(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
    
    func getOuputRequestSection() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections:[OutputRequestSection] = [.ouputRequest]
        output?.setupSections(sections: sections)
    }
    
    
}
