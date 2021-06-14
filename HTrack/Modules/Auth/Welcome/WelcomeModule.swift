//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class WelcomeModule: Module {
    typealias Input = WelcomeModuleInput
    var controller: UIViewController

    required init(coordinator: CoordinatorProtocol, complition: ((WelcomeModuleInput)-> Void)? = nil ) {
        let builder = WelcomeBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
