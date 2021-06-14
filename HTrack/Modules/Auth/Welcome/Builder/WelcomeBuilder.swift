//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class WelcomeBuilder {
	struct WelcomeBuild {
		let view: WelcomeViewController
		let presenter: WelcomePresenter
		let interactor: WelcomeInteractor
		let router: WelcomeRouter

		init(view: WelcomeViewController, presenter: WelcomePresenter, interactor: WelcomeInteractor, router: WelcomeRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> WelcomeBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let welcomeBuild = WelcomeBuild(view: WelcomeViewController(), presenter: WelcomePresenter(), interactor: WelcomeInteractor(), router: WelcomeRouter(), coordinator: coordinator)

		return welcomeBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
