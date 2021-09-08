//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterPresenter {
    weak var output: RegisterModuleOutput?
    weak var view: RegisterViewInput!
    var router: RegisterRouterInput!
    var interactor: RegisterInteractorInput!
    var _state: RegisterViewController.RegisterViewControllerState = .notChecked
    
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
    
    func saveNickname(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setupState(state: .load)
        _state = .nicknameNotExist
        interactor.saveNickname(name: name)
    }
    
    func checkNickName(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.setupState(state: .load)
        _state = .notChecked
        interactor.checkNickName(name: name)
    }
}

// MARK: - RegisterInteractorOutput
extension RegisterPresenter: RegisterInteractorOutput {
    func nicknameState(isExist: Bool) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        if isExist {
            view.setupState(state: .nicknameExist)
        } else {
            view.setupState(state: .nicknameNotExist)
        }
    }
    
    func nicknameIsUpdated() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showMainScreen()
    }
    
    func saveError(error: Error) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) error \(error)")
        
        view.setupState(state: _state)
    }
}

// MARK: - RegisterModuleInput
extension RegisterPresenter: RegisterModuleInput {
    func configure(output: RegisterModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
