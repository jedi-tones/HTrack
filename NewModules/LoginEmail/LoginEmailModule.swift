//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class LoginEmailModule: Module {
    typealias Input = LoginEmailModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((LoginEmailModuleInput)-> Void)? = nil) {
        let builder = LoginEmailBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
