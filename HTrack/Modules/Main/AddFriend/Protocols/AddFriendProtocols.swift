//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol AddFriendViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupState(state: AddFriendHeaderView.AddFriendHeaderState)
    func setupData(newData: [SectionViewModel])
    func closeDrawerView()
}

protocol AddFriendViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
    func didDismissedSheet()
    func addFriendAction(name: String)
    func closeModule()
}


// MARK: - Interactor
protocol AddFriendInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func subscribeInputRequests()
    func getOuputRequestSections()
    func sendAddFriendAction(name: String)
    func addDataListnerFor(section: OutputRequestSection)
}

protocol AddFriendInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [OutputRequestSection])
    func updateOutputRequestData(friends: [MRequestUser])
    func needCloseSheet()
    func showAddFriendError(error: String)
    func addComplite()
}


// MARK: - Router
protocol AddFriendRouterInput {
    // MARK: PRESENTER -> ROUTER
    func closeModule()
}


// MARK: - Presenter (Module)
protocol AddFriendModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: AddFriendModuleOutput)
}

protocol AddFriendModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
