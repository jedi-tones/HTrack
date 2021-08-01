//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterUserInfoPresenter {
    weak var output: RegisterUserInfoModuleOutput?
    weak var view: RegisterUserInfoViewInput!
    var router: RegisterUserInfoRouterInput!
    var interactor: RegisterUserInfoInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterUserInfoViewOutput
extension RegisterUserInfoPresenter: RegisterUserInfoViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
}

// MARK: - RegisterUserInfoInteractorOutput
extension RegisterUserInfoPresenter: RegisterUserInfoInteractorOutput {

}

// MARK: - RegisterUserInfoModuleInput
extension RegisterUserInfoPresenter: RegisterUserInfoModuleInput {
    func configure(output: RegisterUserInfoModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
