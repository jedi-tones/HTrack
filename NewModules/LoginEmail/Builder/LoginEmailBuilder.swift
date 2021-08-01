//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class LoginEmailBuilder {
	struct LoginEmailBuild {
		let view: LoginEmailViewController
		let presenter: LoginEmailPresenter
		let interactor: LoginEmailInteractor
		let router: LoginEmailRouter

		init(view: LoginEmailViewController, presenter: LoginEmailPresenter, interactor: LoginEmailInteractor, router: LoginEmailRouter, coordinator: CoordinatorProtocol) {
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
		}
	}

	func build(coordinator: CoordinatorProtocol) -> LoginEmailBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let loginemailBuild = LoginEmailBuild(view: LoginEmailViewController(), presenter: LoginEmailPresenter(), interactor: LoginEmailInteractor(), router: LoginEmailRouter(), coordinator: coordinator)

		return loginemailBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
