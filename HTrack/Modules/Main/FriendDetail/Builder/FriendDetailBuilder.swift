//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class FriendDetailBuilder {
	struct FriendDetailBuild {
		let view: FriendDetailViewController
		let presenter: FriendDetailPresenter
		let interactor: FriendDetailInteractor
		let router: FriendDetailRouter

		init(view: FriendDetailViewController, presenter: FriendDetailPresenter, interactor: FriendDetailInteractor, router: FriendDetailRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> FriendDetailBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let frienddetailBuild = FriendDetailBuild(view: FriendDetailViewController(), presenter: FriendDetailPresenter(), interactor: FriendDetailInteractor(), router: FriendDetailRouter(), coordinator: coordinator)

		return frienddetailBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
