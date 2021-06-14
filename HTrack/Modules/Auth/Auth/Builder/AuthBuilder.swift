//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class AuthBuilder {
	struct AuthBuild {
		let view: AuthViewController
		let presenter: AuthPresenter
		let interactor: AuthInteractor
		let router: AuthRouter

		init(view: AuthViewController, presenter: AuthPresenter, interactor: AuthInteractor, router: AuthRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> AuthBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let authBuild = AuthBuild(view: AuthViewController(), presenter: AuthPresenter(), interactor: AuthInteractor(), router: AuthRouter(), coordinator: coordinator)

		return authBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
