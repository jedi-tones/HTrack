//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendDetailModule: Module {
    typealias Input = FriendDetailModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((FriendDetailModuleInput)-> Void)? = nil) {
        let builder = FriendDetailBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
