//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class RegisterUserInfoModule: Module {
    typealias Input = RegisterUserInfoModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((RegisterUserInfoModuleInput)-> Void)? = nil) {
        let builder = RegisterUserInfoBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
