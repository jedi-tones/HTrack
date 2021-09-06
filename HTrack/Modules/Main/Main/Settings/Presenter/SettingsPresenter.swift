//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class SettingsPresenter {
    weak var output: SettingsModuleOutput?
    weak var view: SettingsViewInput!
    var router: SettingsRouterInput!
    var interactor: SettingsInteractorInput!

    var viewModel: [SectionViewModel] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - SettingsViewOutput
extension SettingsPresenter: SettingsViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.getSections()
    }
}

// MARK: - SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {
    func setupSections(sections: [SettingsSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
            
            case .control:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
                let elements = interactor.getElementsFor(section: section)
                
                for element in elements {
                    let buttonVM = SettingsButtonViewModel()
                    buttonVM.title = element.title
                    buttonVM.element = element
                    buttonVM.delegate = self
                    sectionVM.items.append(buttonVM)
                }
                
                let header = EmptyHeaderViewModel()
                header.height = 0
                sectionVM.header = header
                newViewModel.append(sectionVM)
            default:
                return
            }
        }
        
        self.viewModel = newViewModel
        view.setupData(newData: viewModel)
    }
    
    func logOutSuccess() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showMainScreen()
    }
}

extension SettingsPresenter: SettingsButtonViewModelDelegate {
    func didTap(element: SettingsElement?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) element title: \(String(describing: element?.rawValue))")
        
        guard let element = element else { return }
        switch element {
        
        case .exit:
            interactor.logOut()
        }
    }
}

// MARK: - SettingsModuleInput
extension SettingsPresenter: SettingsModuleInput {
    func configure(output: SettingsModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
