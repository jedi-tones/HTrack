//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainTabBarModule: Module {
    typealias Input = MainTabBarModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((MainTabBarModuleInput)-> Void)? = nil) {
        let builder = MainTabBarBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
