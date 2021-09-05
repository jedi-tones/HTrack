//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class SettingsModule: Module {
    typealias Input = SettingsModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((SettingsModuleInput)-> Void)? = nil) {
        let builder = SettingsBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
