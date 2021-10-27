//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class FriendsCollectionPresenter {
    weak var output: FriendsCollectionModuleOutput?
    weak var view: FriendsCollectionViewInput!
    var router: FriendsCollectionRouterInput!
    var interactor: FriendsCollectionInteractorInput!
    var serialQ = DispatchQueue(label: "serial")
    var viewModel: [SectionViewModel] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendsCollectionViewOutput
extension FriendsCollectionPresenter: FriendsCollectionViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.getSections()
    }
}

// MARK: - FriendsCollectionInteractorOutput
extension FriendsCollectionPresenter: FriendsCollectionInteractorOutput {
    func setupSections(sections: [FriendsScreenSection]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        var newViewModel: [SectionViewModel] = []
        
        sections.forEach { section in
            switch section {
            case .friends:
                var sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
                let header = EmptyHeaderViewModel()
                sectionVM.header = header
                newViewModel.append(sectionVM)
            }
        }
        
        self.viewModel = newViewModel
        view.setupData(newData: viewModel)
        
        sections.forEach({interactor.addDataListnerFor(section: $0)})
    }
    
    func updateFriendsData(friends: [MUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        serialQ.async {
            updateData()
        }
        
        func updateData() {
            Logger.show(title: "Module",
                        text: "\(type(of: self)) - \(#function)")
            
            var newViewModel = viewModel
            let sectionName = FriendsScreenSection.friends.rawValue
            
            guard let sectionIndex = newViewModel.firstIndex(where: {$0.section == sectionName})
            else { return }
            
            var sectionVM = SectionViewModel(section: sectionName,
                                             header: nil,
                                             footer: nil,
                                             items: [])
            
            for friend in friends {
                let friendVM = FriendViewModel()
                friendVM.friend = friend
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
            
            newViewModel[sectionIndex] = sectionVM
            
            viewModel = newViewModel
            view.setupData(newData: viewModel)
        }
    }
}

// MARK: - FriendsCollectionModuleInput
extension FriendsCollectionPresenter: FriendsCollectionModuleInput {
    func configure(output: FriendsCollectionModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}

extension FriendsCollectionPresenter: FriendViewModelDelegate {
    func didTapFriend(friend: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) friend: \(friend)")
        
        router.showFriendDetailScreen(user: friend)
    }
}
