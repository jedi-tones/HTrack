//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class InputRequestsBuilder {
	struct InputRequestsBuild {
		let view: InputRequestsViewController
		let presenter: InputRequestsPresenter
		let interactor: InputRequestsInteractor
		let router: InputRequestsRouter

		init(view: InputRequestsViewController, presenter: InputRequestsPresenter, interactor: InputRequestsInteractor, router: InputRequestsRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> InputRequestsBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let inputrequestsBuild = InputRequestsBuild(view: InputRequestsViewController(), presenter: InputRequestsPresenter(), interactor: InputRequestsInteractor(), router: InputRequestsRouter(), coordinator: coordinator)

		return inputrequestsBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
