//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class RegisterEmailBuilder {
	struct RegisterEmailBuild {
		let view: RegisterEmailViewController
		let presenter: RegisterEmailPresenter
		let interactor: RegisterEmailInteractor
		let router: RegisterEmailRouter

		init(view: RegisterEmailViewController, presenter: RegisterEmailPresenter, interactor: RegisterEmailInteractor, router: RegisterEmailRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> RegisterEmailBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let registeremailBuild = RegisterEmailBuild(view: RegisterEmailViewController(), presenter: RegisterEmailPresenter(), interactor: RegisterEmailInteractor(), router: RegisterEmailRouter(), coordinator: coordinator)

		return registeremailBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
