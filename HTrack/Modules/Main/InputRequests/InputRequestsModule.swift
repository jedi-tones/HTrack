//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class InputRequestsModule: Module {
    typealias Input = InputRequestsModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((InputRequestsModuleInput)-> Void)? = nil) {
        let builder = InputRequestsBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
