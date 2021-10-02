//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol FriendDetailViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setData(viewModel: FriendDetailViewModel)
}

protocol FriendDetailViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func didDismissedSheet()
}


// MARK: - Interactor
protocol FriendDetailInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    var friendDayCount: Int { get }
    var friendName: String { get }
    func getModuleElements()
    func setFriend(friend: MUser)
    func removeFriend()
}

protocol FriendDetailInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupModule(elements: [FriendsDetailElement])
}


// MARK: - Router
protocol FriendDetailRouterInput {
    // MARK: PRESENTER -> ROUTER
    func closeModule()
}


// MARK: - Presenter (Module)
protocol FriendDetailModuleInput: AnyObject {
    // MARK: IN -> PRESENTER
    func configure(friend: MUser)
    func configure(output: FriendDetailModuleOutput)
}

protocol FriendDetailModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
