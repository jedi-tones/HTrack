//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class AuthModule: Module {
    typealias Input = AuthModuleInput
    
    var controller: UIViewController
    weak var input: AuthModuleInput?

    required init(coordinator: CoordinatorProtocol, complition: ((AuthModuleInput)-> Void)? = nil ) {
        let builder = AuthBuilder()
        let build = builder.build(coordinator: coordinator)
        controller = build.view
        input = build.presenter
        
        complition?(build.presenter)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}
