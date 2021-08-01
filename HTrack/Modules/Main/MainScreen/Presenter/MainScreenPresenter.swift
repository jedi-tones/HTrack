//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

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
        interactor.getSections()
    }
    
    func settingsButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
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
                
                let infoVM = MainScreenInfoViewModel()
                infoVM.title = "Не бухаю"
                infoVM.description = "\(10) Дней"
                infoVM.delegate = self
                sectionVM.items.append(infoVM)
                
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
