//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol FriendsCollectionViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupData(newData: [SectionViewModel])
}

protocol FriendsCollectionViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol FriendsCollectionInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getSections()
    func addDataListnerFor(section: FriendsScreenSection)
}

protocol FriendsCollectionInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [FriendsScreenSection])
    func updateFriendsData(friends: [MUser])
}


// MARK: - Router
protocol FriendsCollectionRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showFriendDetailScreen(user: MUser)
}


// MARK: - Presenter (Module)
protocol FriendsCollectionModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: FriendsCollectionModuleOutput)
}

protocol FriendsCollectionModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
