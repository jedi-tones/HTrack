//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsModule: Module {
    typealias Input = FriendsModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((FriendsModuleInput)-> Void)? = nil) {
        let builder = FriendsBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view

        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
