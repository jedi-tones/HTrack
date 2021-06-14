//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterInteractor {
    weak var output: RegisterInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterInteractorInput
extension RegisterInteractor: RegisterInteractorInput {

}
