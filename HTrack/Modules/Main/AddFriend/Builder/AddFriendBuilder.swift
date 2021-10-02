//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class AddFriendBuilder {
	struct AddFriendBuild {
		let view: AddFriendViewController
		let presenter: AddFriendPresenter
		let interactor: AddFriendInteractor
		let router: AddFriendRouter

		init(view: AddFriendViewController, presenter: AddFriendPresenter, interactor: AddFriendInteractor, router: AddFriendRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> AddFriendBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let addfriendBuild = AddFriendBuild(view: AddFriendViewController(), presenter: AddFriendPresenter(), interactor: AddFriendInteractor(), router: AddFriendRouter(), coordinator: coordinator)

		return addfriendBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
