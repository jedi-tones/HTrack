//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class RegisterEmailModule: Module {
    typealias Input = RegisterEmailModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((RegisterEmailModuleInput)-> Void)? = nil) {
        let builder = RegisterEmailBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
