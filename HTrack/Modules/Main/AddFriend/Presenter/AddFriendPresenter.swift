//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Combine

class AddFriendPresenter {
    weak var output: AddFriendModuleOutput?
    weak var view: AddFriendViewInput?
    var router: AddFriendRouterInput?
    var interactor: AddFriendInteractorInput?
    
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

// MARK: - AddFriendViewOutput
extension AddFriendPresenter: AddFriendViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view?.setupInitialState()
        interactor?.getOuputRequestSections()
    }
    
    func didDismissedSheet() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router?.closeModule()
    }
    
    func addFriendAction(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor?.sendAddFriendAction(name: name)
    }
    
    func closeModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router?.closeModule()
    }
}

// MARK: - AddFriendInteractorOutput
extension AddFriendPresenter: AddFriendInteractorOutput {
    func setupSections(sections: [OutputRequestSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        sections.forEach { section in
            switch section {
                
            case .ouputRequest:
                interactor?.outputRequestsPublisher()
                    .map { updatedOutputRequests -> [FriendOutputRequestViewModel]  in
                        var updatedOutputRequestsVMs: [FriendOutputRequestViewModel] = []
                        
                        updatedOutputRequests.forEach { updatedOutputRequest in
                            let outputRequestVM = FriendOutputRequestViewModel()
                            outputRequestVM.friend = updatedOutputRequest
                            outputRequestVM.delegate = self
                            updatedOutputRequestsVMs.append(outputRequestVM)
                        }
                        return updatedOutputRequestsVMs
                    }
                    .map({ friendsVM -> SectionViewModel in
                        var sectionVM = SectionViewModel(section: section.rawValue,
                                                         header: nil,
                                                         footer: nil,
                                                         items: [])
                        sectionVM.items = friendsVM
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
    
    func showAddFriendError(error: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) error \(error)")
        
        view?.setupState(state: .error(error: error))
    }
    
    func addComplite() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view?.setupState(state: .normal)
    }
    
    func needCloseSheet() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view?.closeDrawerView()
    }
}

// MARK: - AddFriendModuleInput
extension AddFriendPresenter: AddFriendModuleInput {
    func configure(output: AddFriendModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}

extension AddFriendPresenter: FriendOutputRequestViewModelDelegate {
    func didTapCancelRequst(friend: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor?.cancelRequestFor(id: friend.userID)
    }
}
