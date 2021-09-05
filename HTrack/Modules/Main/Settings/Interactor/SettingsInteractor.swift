//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class SettingsInteractor {
    weak var output: SettingsInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - SettingsInteractorInput
extension SettingsInteractor: SettingsInteractorInput {
    func getSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections = [SettingsSection.control]
        output.setupSections(sections: sections)
    }
}
