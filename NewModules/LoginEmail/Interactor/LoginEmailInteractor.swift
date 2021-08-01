//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class LoginEmailInteractor {
    weak var output: LoginEmailInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - LoginEmailInteractorInput
extension LoginEmailInteractor: LoginEmailInteractorInput {

}
