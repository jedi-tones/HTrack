//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AddFriendPresenter {
    weak var output: AddFriendModuleOutput?
    weak var view: AddFriendViewInput!
    var router: AddFriendRouterInput!
    var interactor: AddFriendInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - AddFriendViewOutput
extension AddFriendPresenter: AddFriendViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
    
    func didDismissedSheet() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.closeModule()
    }
}

// MARK: - AddFriendInteractorOutput
extension AddFriendPresenter: AddFriendInteractorOutput {

}

// MARK: - AddFriendModuleInput
extension AddFriendPresenter: AddFriendModuleInput {
    func configure(output: AddFriendModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
