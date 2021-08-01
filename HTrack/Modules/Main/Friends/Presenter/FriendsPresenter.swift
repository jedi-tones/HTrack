//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsPresenter {
    weak var output: FriendsModuleOutput?
    weak var view: FriendsViewInput!
    var router: FriendsRouterInput!
    var interactor: FriendsInteractorInput!
    var images: [UIImage] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendsViewOutput
extension FriendsPresenter: FriendsViewOutput {
    
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
}

// MARK: - FriendsInteractorOutput
extension FriendsPresenter: FriendsInteractorOutput {
    
}

// MARK: - FriendsModuleInput
extension FriendsPresenter: FriendsModuleInput {
    func configure(output: FriendsModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
