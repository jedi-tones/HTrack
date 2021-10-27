//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class FriendsCollectionBuilder {
	struct FriendsCollectionBuild {
		let view: FriendsCollectionViewController
		let presenter: FriendsCollectionPresenter
		let interactor: FriendsCollectionInteractor
		let router: FriendsCollectionRouter

		init(view: FriendsCollectionViewController, presenter: FriendsCollectionPresenter, interactor: FriendsCollectionInteractor, router: FriendsCollectionRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> FriendsCollectionBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let friendscollectionBuild = FriendsCollectionBuild(view: FriendsCollectionViewController(), presenter: FriendsCollectionPresenter(), interactor: FriendsCollectionInteractor(), router: FriendsCollectionRouter(), coordinator: coordinator)

		return friendscollectionBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
