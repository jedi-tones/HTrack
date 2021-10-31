//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsPresenter {
    weak var output: FriendsModuleOutput?
    weak var view: FriendsViewInput?
    var router: FriendsRouterInput!
    var interactor: FriendsInteractorInput!
    var _currentPage: FriendsPage = .friendsCollection {
        didSet {
            view?.selectPage(page: _currentPage)
        }
    }
    var pages: [FriendsPage] = []
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    private func setupSubModule() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        pages = interactor.getPages()
        pages.forEach {[weak self] submoduleTab in
            self?.router.addSubmodule(page: submoduleTab,
                                      friendsOutput: nil,
                                      requestOutput: nil)
        }
        
        view?.setPages(pages)
        if let firstPage = self.pages.first {
            selectPage(firstPage, force: true)
        }
    }
    
    func selectPage(_ page: FriendsPage, force: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            if self?._currentPage != page || force {
                self?._currentPage = page
            }
        }
    }
}

// MARK: - FriendsViewOutput
extension FriendsPresenter: FriendsViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view?.setupInitialState()
        interactor.subscribeUserListner()
        setupSubModule()
    }
    
    func screenToggleChangeToIndex(_ index: Int) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard pages.count > index else { return }
        let page = pages[index]
        selectPage(page)
    }
    
    func getSubmoduleController(page: FriendsPage) -> UIViewController? {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        return router.getSubmoduleController(page: page)
    }
    
    func addFriendButtonTapped() {
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
        
        view?.updateNickname(nickName: user.name ?? "")
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
