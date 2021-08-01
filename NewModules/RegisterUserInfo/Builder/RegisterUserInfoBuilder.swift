//  Created by Denis Shchigolev on 21/07/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class RegisterUserInfoBuilder {
	struct RegisterUserInfoBuild {
		let view: RegisterUserInfoViewController
		let presenter: RegisterUserInfoPresenter
		let interactor: RegisterUserInfoInteractor
		let router: RegisterUserInfoRouter

		init(view: RegisterUserInfoViewController, presenter: RegisterUserInfoPresenter, interactor: RegisterUserInfoInteractor, router: RegisterUserInfoRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> RegisterUserInfoBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let registeruserinfoBuild = RegisterUserInfoBuild(view: RegisterUserInfoViewController(), presenter: RegisterUserInfoPresenter(), interactor: RegisterUserInfoInteractor(), router: RegisterUserInfoRouter(), coordinator: coordinator)

		return registeruserinfoBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
