//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class MainScreenPresenter {
    weak var output: MainScreenModuleOutput?
    weak var view: MainScreenViewInput!
    var router: MainScreenRouterInput!
    var interactor: MainScreenInteractorInput!
    
    var viewModel: [SectionViewModel] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        let user = interactor.getUser()
        updateUserStat(user: user)
    }
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    func updateUserStat(user: MUser?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let count = String(user?.startDate?.getDayCount() ?? 0)
        let infoVM = MainScreenInfoViewModel(title: "Дней без алкоголя:",
                                             count: count)
        
        view.update(vm: infoVM)
    }
}

// MARK: - MainScreenModuleInput
extension MainScreenPresenter: MainScreenModuleInput {
    func configure(output: MainScreenModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
