//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterPresenter {
    weak var output: RegisterModuleOutput?
    weak var view: RegisterViewInput!
    var router: RegisterRouterInput!
    var interactor: RegisterInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterViewOutput
extension RegisterPresenter: RegisterViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
    }
    
    func saveNickname() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
}

// MARK: - RegisterInteractorOutput
extension RegisterPresenter: RegisterInteractorOutput {

}

// MARK: - RegisterModuleInput
extension RegisterPresenter: RegisterModuleInput {
    func configure(output: RegisterModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
