//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class AddFriendModule: Module {
    typealias Input = AddFriendModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((AddFriendModuleInput)-> Void)? = nil) {
        let builder = AddFriendBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
