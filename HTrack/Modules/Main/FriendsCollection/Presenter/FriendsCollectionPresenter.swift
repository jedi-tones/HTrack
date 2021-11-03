//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import Combine

class FriendsCollectionPresenter {
    weak var output: FriendsCollectionModuleOutput?
    weak var view: FriendsCollectionViewInput!
    var router: FriendsCollectionRouterInput!
    var interactor: FriendsCollectionInteractorInput!
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
        
        sections.forEach { section in
            switch section {
            case .friends:
                interactor.friendsPublisher()
                    .map { updateFriends -> [FriendViewModel]  in
                        var friendsVMs: [FriendViewModel] = []
                        updateFriends.forEach { updatedFriend in
                            let friendVM = FriendViewModel()
                            friendVM.friend = updatedFriend
                            friendVM.delegate = self
                            friendsVMs.append(friendVM)
                        }
                        return friendsVMs
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
