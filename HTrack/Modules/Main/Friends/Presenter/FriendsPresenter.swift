//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsPresenter {
    weak var output: FriendsModuleOutput?
    weak var view: FriendsViewInput!
    var router: FriendsRouterInput!
    var interactor: FriendsInteractorInput!
    var serialQ = DispatchQueue(label: "serial")
    var viewModel: [SectionViewModel] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendsViewOutput
extension FriendsPresenter: FriendsViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.subscribeUserListner()
        interactor.getSections()
    }
    
    func addFriendButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showAddFriendScreen()
    }
    
    func settingsButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.showSettinsScreen()
    }
}

// MARK: - FriendsInteractorOutput
extension FriendsPresenter: FriendsInteractorOutput {
    func userUpdated(user: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        view.updateNickname(nickName: user.name ?? "")
    }
    
    func setupSections(sections: [FriendsScreenSection]) {
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
            
            case .friends:
                let sectionVM = SectionViewModel(section: section.rawValue,
                                                 header: nil,
                                                 footer: nil,
                                                 items: [])
                
//                for _ in 1...10 {
//                    let friendVM = FriendViewModel()
//                    friendVM.delegate = self
//                    sectionVM.items.append(friendVM)
//                }
//                
//                let header = TextHeaderWithCounterViewModel()
//                header.title = section.rawValue
//                
//                sectionVM.header = header
                newViewModel.append(sectionVM)
            }
        }
        
        self.viewModel = newViewModel
        view.setupData(newData: viewModel)
        
        sections.forEach({interactor.addDataListnerFor(section: $0)})
    }
    
    func updateFriendsData(friends: [MUser]) {
        
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
    
    func updateRequestData(requests: [MRequestUser]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        serialQ.async {
            updateData()
        }
        
        func updateData() {
            var newViewModel = viewModel
            let sectionName = FriendsScreenSection.inputRequest.rawValue
            
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

extension FriendsPresenter: FriendInputRequestViewModelDelegate {
    func tapInputRequest(user: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) request: \(user)")
        
        router.showInputRequestDetailScreen(inputRequest: user)
    }
}

extension FriendsPresenter: FriendViewModelDelegate {
    func didTapFriend(friend: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) friend: \(friend)")
        
        router.showFriendDetailScreen(user: friend)
    }
}

// MARK: - FriendsModuleInput
extension FriendsPresenter: FriendsModuleInput {
    func configure(output: FriendsModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
