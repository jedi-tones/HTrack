//
//  FriendsViewController+Transition.swift
//  HTrack
//
//  Created by Jedi Tones on 10/27/21.
//

import Foundation

extension FriendsViewController {
    func transitionToSubmodule(page: FriendsPage) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        guard let controller = output?.getSubmoduleController(page: page) else {
            Logger.show(title: "Module ERROR",
                        text: "\(type(of: self)) - \(#function) don't have submodule controller")
            return }
        
        transitionToViewController(viewController: controller, animated: false)
    }
}
