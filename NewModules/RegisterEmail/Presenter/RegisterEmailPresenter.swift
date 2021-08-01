//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterEmailPresenter {
    weak var output: RegisterEmailModuleOutput?
    weak var view: RegisterEmailViewInput!
    var router: RegisterEmailRouterInput!
    var interactor: RegisterEmailInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterEmailViewOutput
extension RegisterEmailPresenter: RegisterEmailViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
}

// MARK: - RegisterEmailInteractorOutput
extension RegisterEmailPresenter: RegisterEmailInteractorOutput {

}

// MARK: - RegisterEmailModuleInput
extension RegisterEmailPresenter: RegisterEmailModuleInput {
    func configure(output: RegisterEmailModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
