//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendDetailPresenter {
    weak var output: FriendDetailModuleOutput?
    weak var view: FriendDetailViewInput!
    var router: FriendDetailRouterInput!
    var interactor: FriendDetailInteractorInput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - FriendDetailViewOutput
extension FriendDetailPresenter: FriendDetailViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        interactor.getModuleElements()
    }
    
    func didDismissedSheet() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        router.closeModule()
    }
}

// MARK: - FriendDetailInteractorOutput
extension FriendDetailPresenter: FriendDetailInteractorOutput {
    func setupModule(elements: [FriendsDetailElement]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        let viewModel = FriendDetailViewModel()
        var blocks: [FriendDetailViewModel.ViewBlock] = []
        
        viewModel.sheetHeaderTitle = interactor.friendName
        
        elements.forEach { element in
            switch element {
            case .title:
                let block = FriendDetailViewModel.ViewBlock.title(title: "Дней без алкоголя")
                blocks.append(block)
                
            case .counter:
                let block = FriendDetailViewModel.ViewBlock.counter(count: interactor.friendDayCount)
                blocks.append(block)
                
            case .removeButton:
                let block = FriendDetailViewModel.ViewBlock.removeButton(title: "Удалить друга")
                blocks.append(block)
            }
        }
        
        viewModel.configure(viewBlocks: blocks)
        viewModel.delegate = self
        
        view.setData(viewModel: viewModel)
    }
}

extension FriendDetailPresenter: FriendDetailViewModelDelegate{
    func removeButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor.removeFriend()
    }
}

// MARK: - FriendDetailModuleInput
extension FriendDetailPresenter: FriendDetailModuleInput {
    func configure(output: FriendDetailModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
    
    func configure(friend: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        interactor.setFriend(friend: friend)
    }
}
