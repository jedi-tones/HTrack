//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class MainScreenBuilder {
	struct MainScreenBuild {
		let view: MainScreenViewController
		let presenter: MainScreenPresenter
		let interactor: MainScreenInteractor
		let router: MainScreenRouter

		init(view: MainScreenViewController, presenter: MainScreenPresenter, interactor: MainScreenInteractor, router: MainScreenRouter, coordinator: CoordinatorProtocol) {
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
		}
	}

	func build(coordinator: CoordinatorProtocol) -> MainScreenBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let mainscreenBuild = MainScreenBuild(view: MainScreenViewController(), presenter: MainScreenPresenter(), interactor: MainScreenInteractor(), router: MainScreenRouter(), coordinator: coordinator)

		return mainscreenBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
