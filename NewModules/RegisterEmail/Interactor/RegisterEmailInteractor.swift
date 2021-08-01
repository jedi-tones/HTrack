//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterEmailInteractor {
    weak var output: RegisterEmailInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterEmailInteractorInput
extension RegisterEmailInteractor: RegisterEmailInteractorInput {

}
