//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class SettingsPresenter {
    weak var output: SettingsModuleOutput?
    weak var view: SettingsViewInput!
    var router: SettingsRouterInput!
    var interactor: SettingsInteractorInput!

    var viewModels: [SectionViewModel] = []
    
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
    func updateUser(user: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        guard let startDate = user.startDate else { return }
        var updatedViewModels = viewModels
        
        guard let dateSectionIndex = updatedViewModels.firstIndex(where: {$0.section == SettingsSection.settings.rawValue})
        else { return }
        
        guard let pickerVMIndex = updatedViewModels[dateSectionIndex].items.firstIndex(where: {$0 is DatePickerCellViewModel})
        else { return }
        
        let pickerVM = DatePickerCellViewModel()
        pickerVM.title = SettingsElement.datePicker.title
        pickerVM.startDate = startDate
        pickerVM.delegate = self
        
        updatedViewModels[dateSectionIndex].items[pickerVMIndex] = pickerVM
        
        viewModels = updatedViewModels
        
        guard let view = view else { return }
        view.setupData(newData: viewModels)
    }
    func setupSections(sections: [SettingsSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
            
            case .settings:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
                let elements = interactor.getElementsFor(section: section)
                
                for element in elements {
                    switch element {
                    case .datePicker:
                        let vm = DatePickerCellViewModel()
                        vm.title = element.title
                        vm.startDate = nil
                        vm.delegate = self
                        sectionVM.items.append(vm)
                    case .reset:
                        let buttonVM = SettingsButtonViewModel()
                        buttonVM.title = element.title
                        buttonVM.element = element
                        buttonVM.sensetive = false
                        buttonVM.delegate = self
                        sectionVM.items.append(buttonVM)
                    default:
                        break
                    }
                }
                
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                newViewModel.append(sectionVM)
                
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
                    buttonVM.sensetive = true
                    buttonVM.delegate = self
                    sectionVM.items.append(buttonVM)
                }
                
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                newViewModel.append(sectionVM)
            default:
                return
            }
        }
        
        self.viewModels = newViewModel
        view.setupData(newData: viewModels)
        
        interactor.getUserData()
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
        case .reset:
            interactor.changeStartDate(to: Date())
        default:
            return
        }
    }
}

extension SettingsPresenter: DatePickerCellViewModelDelegate {
    func dateChanged(date: Date) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) new date: \(date)")
        
        interactor.changeStartDate(to: date)
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
