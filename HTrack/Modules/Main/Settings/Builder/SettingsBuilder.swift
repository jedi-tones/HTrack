//  Created by Denis Shchigolev on 03/09/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class SettingsBuilder {
	struct SettingsBuild {
		let view: SettingsViewController
		let presenter: SettingsPresenter
		let interactor: SettingsInteractor
		let router: SettingsRouter

		init(view: SettingsViewController, presenter: SettingsPresenter, interactor: SettingsInteractor, router: SettingsRouter, coordinator: CoordinatorProtocol) {
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

	func build(coordinator: CoordinatorProtocol) -> SettingsBuild {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

		let settingsBuild = SettingsBuild(view: SettingsViewController(), presenter: SettingsPresenter(), interactor: SettingsInteractor(), router: SettingsRouter(), coordinator: coordinator)

		return settingsBuild
	}

	deinit {
		Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
	}
}
