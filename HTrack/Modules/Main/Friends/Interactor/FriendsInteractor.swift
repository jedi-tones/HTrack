//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendsInteractor {
    weak var output: FriendsInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendsInteractorInput
extension FriendsInteractor: FriendsInteractorInput {

}
