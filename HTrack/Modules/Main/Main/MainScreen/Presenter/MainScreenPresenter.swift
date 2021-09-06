//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

protocol MainScreenUpdateDelegate {
    func update(info: MainScreenInfoViewModel)
}

class MainScreenPresenter {
    weak var output: MainScreenModuleOutput?
    weak var view: MainScreenViewInput!
    var router: MainScreenRouterInput!
    var interactor: MainScreenInteractorInput!
    
    var mainScreenUpdateDelegate: MainScreenUpdateDelegate?
    
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
        interactor.getSections()
    }
    
    func settingsButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showSettinsScreen()
    }
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    func updateUserStat(user: MUser?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        let infoVM = MainScreenInfoViewModel()
        
        if let user = user {
            if let name = user.name {
                view.updateTitle(title: name)
            }
            
            infoVM.title = user.startDate?.getPeriod() ?? " "
        } else {
            infoVM.title = Date().getPeriod()
            view.updateTitle(title: MainTabBarTabs.main.title)
        }
      
        infoVM.description = "Без алко"
        mainScreenUpdateDelegate?.update(info: infoVM)
    }
    
    func setupSections(sections: [MainScreenSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
            
            case .info:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                let user = interactor.getUser()
                let startDate = user?.startDate
                
                let infoVM = MainScreenInfoViewModel()
                infoVM.title = "Без алко"
                infoVM.description = startDate?.getPeriod() ?? " "
                infoVM.delegate = self
                sectionVM.items.append(infoVM)
                
                //for later update without reload collection
                mainScreenUpdateDelegate = infoVM
                
                let header = EmptyHeaderViewModel()
                header.height = 0
                sectionVM.header = header
                newViewModel.append(sectionVM)
            }
        }
        
        self.viewModel = newViewModel
        view.setupData(newData: viewModel)
    }
}

// MARK: - InfoViewModelDelegate
extension MainScreenPresenter: InfoViewModelDelegate {
    func didTapInfo() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
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
