//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class FriendsBuilder {
	struct FriendsBuild {
		let view: FriendsViewController
		let presenter: FriendsPresenter
		let interactor: FriendsInteractor
		let router: FriendsRouter

		init(view: FriendsViewController, presenter: FriendsPresenter, interactor: FriendsInteractor, router: FriendsRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> FriendsBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let friendsBuild = FriendsBuild(view: FriendsViewController(), presenter: FriendsPresenter(), interactor: FriendsInteractor(), router: FriendsRouter(), coordinator: coordinator)

		return friendsBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
