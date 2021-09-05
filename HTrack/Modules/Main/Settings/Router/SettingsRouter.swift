//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class SettingsRouter: SettingsRouterInput {
    weak var controller: Presentable?
    weak var coordinator: CoordinatorProtocol?

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
