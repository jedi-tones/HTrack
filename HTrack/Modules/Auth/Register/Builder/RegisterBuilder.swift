//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class RegisterBuilder {
	struct RegisterBuild {
		let view: RegisterViewController
		let presenter: RegisterPresenter
		let interactor: RegisterInteractor
		let router: RegisterRouter

		init(view: RegisterViewController, presenter: RegisterPresenter, interactor: RegisterInteractor, router: RegisterRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> RegisterBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let registerBuild = RegisterBuild(view: RegisterViewController(), presenter: RegisterPresenter(), interactor: RegisterInteractor(), router: RegisterRouter(), coordinator: coordinator)

		return registerBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
