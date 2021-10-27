//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsCollectionModule: Module {
    typealias Input = FriendsCollectionModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((FriendsCollectionModuleInput)-> Void)? = nil) {
        let builder = FriendsCollectionBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
