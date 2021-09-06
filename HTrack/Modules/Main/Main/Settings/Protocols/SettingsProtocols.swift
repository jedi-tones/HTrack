//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

// MARK: - View
protocol SettingsViewInput: AnyObject {
    // MARK: PRESENTER -> VIEW
    func setupInitialState()
    func setupData(newData: [SectionViewModel])
}

protocol SettingsViewOutput {
    // MARK: VIEW -> PRESENTER
    func viewIsReady()
}


// MARK: - Interactor
protocol SettingsInteractorInput {
    // MARK: PRESENTER -> INTERACTOR
    func getSections()
    func getElementsFor(section: SettingsSection) -> [SettingsElement]
    func logOut()
}

protocol SettingsInteractorOutput: AnyObject {
    // MARK: INTERACTOR -> PRESENTER
    func setupSections(sections: [SettingsSection])
    func logOutSuccess()
}


// MARK: - Router
protocol SettingsRouterInput {
    // MARK: PRESENTER -> ROUTER
    func showMainScreen()
}


// MARK: - Presenter (Module)
protocol SettingsModuleInput: AnyObject {
    // MARK: IN -> PRESENTER

    func configure(output: SettingsModuleOutput)
}

protocol SettingsModuleOutput: AnyObject  {
    // MARK: PRESENTER -> OUT
}
