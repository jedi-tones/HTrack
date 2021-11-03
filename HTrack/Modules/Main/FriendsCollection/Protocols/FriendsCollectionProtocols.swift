//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import Combine

// MARK: - View
protocol FriendsCollectionViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol FriendsCollectionViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    
    var viewModelPublisher: AnyPublisher<[SectionViewModel], Never> { get }
}


// MARK: - Interactor
protocol FriendsCollectionInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getSections()
    
    func friendsPublisher() -> AnyPublisher<[MUser], Never>
}

protocol FriendsCollectionInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [FriendsScreenSection])
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
