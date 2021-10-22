//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

// MARK: - View
protocol FriendsViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupData(newData: [SectionViewModel])
    func updateNickname(nickName: String)
}

protocol FriendsViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func addFriendButtonTapped()
    func settingsButtonTapped()
}


// MARK: - Interactor
protocol FriendsInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getSections()
    func subscribeUserListner()
    func addDataListnerFor(section: FriendsScreenSection)
    func cancelUserRequest(id: String)
    func accepUserRequest(id: String)
}

protocol FriendsInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [FriendsScreenSection])
    func updateFriendsData(friends: [MUser])
    func updateRequestData(requests: [MRequestUser])
    func userUpdated(user: MUser)
}


// MARK: - Router
protocol FriendsRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showSettinsScreen()
    func showAddFriendScreen()
    func showFriendDetailScreen(user: MUser)
}


// MARK: - Presenter (Module)
protocol FriendsModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: FriendsModuleOutput)
}

protocol FriendsModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
