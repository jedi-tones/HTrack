//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainTabBarViewController: UITabBarController {
    // MARK: Properties
    var output: MainTabBarViewOutput!

    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

extension MainTabBarViewController {
    // MARK: Methods
    func setupViews() {
        
        setupTabBar()
        setupConstraints()
    }

    func setupConstraints() {

    }
    
    private func setupTabBar() {
    //    view.backgroundColor = Colors.myWhiteColor()
        
        let appearance = tabBar.standardAppearance.copy()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundColor = Colors.myWhiteColor()
        tabBar.standardAppearance = appearance
        
        let appearanceTabBarItem = UITabBarItemAppearance(style: .stacked)
        appearanceTabBarItem.normal.badgeBackgroundColor = Colors.mySecondSatColor()
        appearanceTabBarItem.normal.badgeTextAttributes = [NSAttributedString.Key.font : Fonts.AvenirFonts.avenirNextBold(size: 11)]
        appearanceTabBarItem.selected.badgeBackgroundColor = Colors.mySecondSatColor()
        appearanceTabBarItem.selected.badgeTextAttributes = [NSAttributedString.Key.font : Fonts.AvenirFonts.avenirNextBold(size: 11)]
        
        tabBar.standardAppearance.stackedLayoutAppearance = appearanceTabBarItem
        
        tabBar.unselectedItemTintColor = Colors.myLightGrayColor()
        tabBar.tintColor = Colors.myLabelColor()
    }
}

// MARK: - MainTabBarViewInput
extension MainTabBarViewController: MainTabBarViewInput {
    func setupTabs(tabs: [MainTabBarTabs]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let navControllers = tabs.map({ tab -> UINavigationController in
            let navController = UINavigationController()
            navController.setupNavigationController(image: tab.image,
                                                    title: tab.title,
                                                    tag: tab.tag)
            return navController
        })
        
        viewControllers = navControllers
        
        output.startCoordinatorsFor(navigators: navControllers)
    }
    
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
}
