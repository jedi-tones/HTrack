//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import Combine

class InputRequestsPresenter {
    weak var output: InputRequestsModuleOutput?
    weak var view: InputRequestsViewInput!
    var router: InputRequestsRouterInput!
    var interactor: InputRequestsInteractorInput!
    var serialQ = DispatchQueue(label: "serial")
    var viewModel: [SectionViewModel] = []
    
    var cancelleble: Set<AnyCancellable> = []
    var viewModelPublisher: AnyPublisher<[SectionViewModel], Never> {
        _viewModelPublisher.eraseToAnyPublisher()
    }
    let _viewModelPublisher = CurrentValueSubject<[SectionViewModel], Never>([])
    
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
        
        sections.forEach { section in
            switch section {
                
            case .inputRequest:
                interactor.inputRequestPubliser()
                    .map { updateInputRequests -> [FriendInputRequestViewModel]  in
                        var inputRequestVMs: [FriendInputRequestViewModel] = []
                        updateInputRequests.forEach { updateInputRequest in
                            let inputRequestVM = FriendInputRequestViewModel()
                            inputRequestVM.requestUser = updateInputRequest
                            inputRequestVM.delegate = self
                            inputRequestVMs.append(inputRequestVM)
                        }
                        return inputRequestVMs
                    }
                    .map({ inputRequestVMs -> SectionViewModel in
                        var sectionVM = SectionViewModel(section: section.rawValue,
                                                         header: nil,
                                                         footer: nil,
                                                         items: [])
                        sectionVM.items = inputRequestVMs
                        return sectionVM
                    })
                    .sink {[weak self] sectionVM in
                        var currentViewModel = self?._viewModelPublisher.value
                        if let indexVM = currentViewModel?.firstIndex(where: {$0.section == sectionVM.section}) {
                            currentViewModel?.remove(at: indexVM)
                            currentViewModel?.insert(sectionVM, at: indexVM)
                        } else {
                            currentViewModel?.append(sectionVM)
                        }
                        
                        guard let currentViewModel = currentViewModel else { return }
                        self?._viewModelPublisher.send(currentViewModel)
                    }
                    .store(in: &cancelleble)
            }
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
    
    func tapAcceptRequest(user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) request: \(user)")
        
        interactor.acceptUser(user)
    }
    
    func tapRejectRequest(user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) request: \(user)")
        
        interactor.rejectUser(user)
    }
}
