//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class AddFriendPresenter {
    weak var output: AddFriendModuleOutput?
    weak var view: AddFriendViewInput?
    var router: AddFriendRouterInput?
    var interactor: AddFriendInteractorInput?
    var viewModel: [SectionViewModel] = []
    
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
        interactor?.subscribeInputRequests()
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
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
                
            case .ouputRequest:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
                
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                newViewModel.append(sectionVM)
            }
            
            self.viewModel = newViewModel
            view?.setupData(newData: viewModel)
            
            sections.forEach({interactor?.addDataListnerFor(section: $0)})
        }
    }
    
    func updateOutputRequestData(friends: [MRequestUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel = viewModel
        
        let sectionName = OutputRequestSection.ouputRequest.rawValue
        
        guard let sectionIndex = newViewModel.firstIndex(where: {$0.section == sectionName})
        else { return }
        
        var sectionVM = SectionViewModel(section: sectionName,
                                         header: nil,
                                         footer: nil,
                                         items: [])
        
        for friend in friends {
            let friendVM = FriendOutputRequestViewModel()
            friendVM.friend = friend
            friendVM.delegate = self
            sectionVM.items.append(friendVM)
        }
        
        if sectionVM.items.isNotEmpty {
            let header = TextHeaderWithCounterViewModel()
            header.title = sectionName
            header.count = sectionVM.items.count
            sectionVM.header = header
        } else {
            let header = EmptyHeaderViewModel()
            sectionVM.header = header
        }
        
        newViewModel[sectionIndex] = sectionVM
        
        viewModel = newViewModel
        view?.setupData(newData: viewModel)
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
