//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class MainTabBarBuilder {
	struct MainTabBarBuild {
		let view: MainTabBarViewController
		let presenter: MainTabBarPresenter
		let interactor: MainTabBarInteractor
		let router: MainTabBarRouter

		init(view: MainTabBarViewController, presenter: MainTabBarPresenter, interactor: MainTabBarInteractor, router: MainTabBarRouter, coordinator: CoordinatorProtocol) {
			self.view = view
			self.presenter = presenter
			self.interactor = interactor
			self.router = router

			self.view.output = self.presenter

			self.presenter.interactor = self.interactor
			self.presenter.view = self.view
			self.presenter.router = self.router

			self.interactor.output = self.presenter

			self.router.controller = self.view
            self.router.coordinator = coordinator
            
            view.output.viewIsReady()
		}
	}

    func build(coordinator: CoordinatorProtocol) -> MainTabBarBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let maintabbarBuild = MainTabBarBuild(view: MainTabBarViewController(),
                                              presenter: MainTabBarPresenter(),
                                              interactor: MainTabBarInteractor(),
                                              router: MainTabBarRouter(),
                                              coordinator: coordinator)

		return maintabbarBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
