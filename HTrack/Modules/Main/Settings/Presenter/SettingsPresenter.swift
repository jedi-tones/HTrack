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
                
                if let elements = section.sectionElements {
                    for element in elements {
                        let controlVM = TextCollectionCellViewModel()
                        controlVM.title = element.rawValue
                        controlVM.delegate = self
                        sectionVM.items.append(controlVM)
                    }
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
}

extension SettingsPresenter: TextCollectionCellViewModelDelegate {
    func didTap(title: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) element title: \(title)")
        
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
