//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class WelcomeInteractor {
    weak var output: WelcomeInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - WelcomeInteractorInput
extension WelcomeInteractor: WelcomeInteractorInput {

}
