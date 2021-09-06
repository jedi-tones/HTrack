//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainScreenModule: Module {
    typealias Input = MainScreenModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((MainScreenModuleInput)-> Void)? = nil) {
        let builder = MainScreenBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view

        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
