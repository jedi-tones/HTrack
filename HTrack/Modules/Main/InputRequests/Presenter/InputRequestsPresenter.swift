//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class InputRequestsPresenter {
    weak var output: InputRequestsModuleOutput?
    weak var view: InputRequestsViewInput!
    var router: InputRequestsRouterInput!
    var interactor: InputRequestsInteractorInput!
    var serialQ = DispatchQueue(label: "serial")
    var viewModel: [SectionViewModel] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - InputRequestsViewOutput
extension InputRequestsPresenter: InputRequestsViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.getSections()
    }
}

// MARK: - InputRequestsInteractorOutput
extension InputRequestsPresenter: InputRequestsInteractorOutput {
    func setupSections(sections: [InputRequestSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
                
            case .inputRequest:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
                
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                newViewModel.append(sectionVM)
            }
            
            self.viewModel = newViewModel
            view.setupData(newData: viewModel)
            
            sections.forEach({interactor.addDataListnerFor(section: $0)})
        }
    }
    
    func updateRequestData(requests: [MRequestUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        serialQ.async {
            updateData()
        }
        
        func updateData() {
            var newViewModel = viewModel
            let sectionName = InputRequestSection.inputRequest.rawValue
            
            guard let _ = newViewModel.firstIndex(where: {$0.section == sectionName})
            else { return }
            
            var sectionVM = SectionViewModel(section: sectionName,
                                             header: nil,
                                             footer: nil,
                                             items: [])
            
            for requestUser in requests {
                let friendVM = FriendInputRequestViewModel()
                friendVM.requestUser = requestUser
                friendVM.delegate = self
                sectionVM.items.append(friendVM)
            }
            
            if sectionVM.items.isNotEmpty {
                let header = TextHeaderWithCounterViewModel()
                header.title = sectionName
                header.count = sectionVM.items.count
                sectionVM.header = header
                sectionVM.headerCounter = sectionVM.items.count
            } else {
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                sectionVM.headerCounter = 0
            }
            
            newViewModel.removeAll(where: {$0.section == sectionName})
            newViewModel.insert(sectionVM, at: 0)
            
            viewModel = newViewModel
            view.setupData(newData: viewModel)
        }
    }
}

// MARK: - InputRequestsModuleInput
extension InputRequestsPresenter: InputRequestsModuleInput {
    func configure(output: InputRequestsModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}

extension InputRequestsPresenter: FriendInputRequestViewModelDelegate {
    func tapInputRequest(user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) request: \(user)")
        
        router.showInputRequestDetailScreen(inputRequest: user)
    }
}
