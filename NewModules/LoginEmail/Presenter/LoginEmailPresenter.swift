//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class LoginEmailPresenter {
    weak var output: LoginEmailModuleOutput?
    weak var view: LoginEmailViewInput!
    var router: LoginEmailRouterInput!
    var interactor: LoginEmailInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - LoginEmailViewOutput
extension LoginEmailPresenter: LoginEmailViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
}

// MARK: - LoginEmailInteractorOutput
extension LoginEmailPresenter: LoginEmailInteractorOutput {

}

// MARK: - LoginEmailModuleInput
extension LoginEmailPresenter: LoginEmailModuleInput {
    func configure(output: LoginEmailModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
