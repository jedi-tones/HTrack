//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class SettingsInteractor {
    weak var output: SettingsInteractorOutput!

    var appManager = AppManager.shared
    
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
    
    func getElementsFor(section: SettingsSection) -> [SettingsElement] {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        switch section {
        
        case .settings:
            return []
        case .control:
            return [.exit]
        case .info:
            return []
        }
    }
    
    func logOut() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        do {
           try appManager.logOut()
            output.logOutSuccess()
        } catch {
            Logger.show(title: "Module",
                        text: "\(type(of: self)) - \(#function) error LogOut: \(error)",
                        withHeader: true,
                        withFooter: true)
        }
    }
}
