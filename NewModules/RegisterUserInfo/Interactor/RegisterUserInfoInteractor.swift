//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterUserInfoInteractor {
    weak var output: RegisterUserInfoInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterUserInfoInteractorInput
extension RegisterUserInfoInteractor: RegisterUserInfoInteractorInput {

}
