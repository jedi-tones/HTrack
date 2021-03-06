//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation
import Combine

// MARK: - View
protocol InputRequestsViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
}

protocol InputRequestsViewOutput {
    // MARK: VIEW -> PRESENTER
    var viewModelPublisher: AnyPublisher<[SectionViewModel], Never> { get }
    func viewIsReady()
}


// MARK: - Interactor
protocol InputRequestsInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getSections()
    func inputRequestPubliser() -> AnyPublisher<[MRequestUser], Never> 
    func acceptUser(_ user: MRequestUser)
    func rejectUser(_ user: MRequestUser)
}

protocol InputRequestsInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [InputRequestSection])
}


// MARK: - Router
protocol InputRequestsRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showInputRequestDetailScreen(inputRequest: MRequestUser)
}


// MARK: - Presenter (Module)
protocol InputRequestsModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: InputRequestsModuleOutput)
}

protocol InputRequestsModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
