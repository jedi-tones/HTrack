//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

// MARK: - View
protocol FriendsViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func updateNickname(nickName: String)
    func selectPage(page: FriendsPage)
    func setPages(_ pages: [FriendsPage])
    func setAddButton(isHidden: Bool)
}

protocol FriendsViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func addFriendButtonTapped()
    func settingsButtonTapped()
    func getSubmoduleController(page: FriendsPage) -> UIViewController?
    func screenToggleChangeToIndex(_ index: Int)
}


// MARK: - Interactor
protocol FriendsInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getPages() -> [FriendsPage]
    func subscribeUserListner()
}

protocol FriendsInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func userUpdated(user: MUser)
}


// MARK: - Router
protocol FriendsRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showSettinsScreen()
    func showAddFriendScreen()

    func addSubmodule(page: FriendsPage, friendsOutput: FriendsCollectionModuleOutput?, requestOutput: InputRequestsModuleOutput?)
    func getSubmoduleController(page: FriendsPage) -> UIViewController?
}


// MARK: - Presenter (Module)
protocol FriendsModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: FriendsModuleOutput)
}

protocol FriendsModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
