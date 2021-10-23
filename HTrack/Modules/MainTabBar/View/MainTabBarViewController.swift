//  Created by Denis Shchigolev on 13/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class MainTabBarViewController: UITabBarController {
    // MARK: Properties
    var output: MainTabBarViewOutput!

  

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }


    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

extension MainTabBarViewController {
    // MARK: Methods
    func setupViews() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        setupTabBar()
        setupConstraints()
    }

    func setupConstraints() {

    }
    
    func startCheckAuth() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        output.checkAuth()
    }
    
    private func setupTabBar() {
    //    view.backgroundColor = Colors.myWhiteColor()
        
        let appearance = tabBar.standardAppearance.copy()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundColor = Styles.Colors.myBackgroundColor()
        tabBar.standardAppearance = appearance
        
        let appearanceTabBarItem = UITabBarItemAppearance(style: .stacked)
        appearanceTabBarItem.normal.badgeBackgroundColor = Styles.Colors.badgeColor()
        appearanceTabBarItem.normal.badgeTextAttributes = [NSAttributedString.Key.font : Styles.Fonts.AvenirFonts.avenirNextBold(size: 11).font]
        appearanceTabBarItem.selected.badgeBackgroundColor = Styles.Colors.badgeColor()
        appearanceTabBarItem.selected.badgeTextAttributes = [NSAttributedString.Key.font : Styles.Fonts.AvenirFonts.avenirNextBold(size: 11).font]
        
        tabBar.standardAppearance.stackedLayoutAppearance = appearanceTabBarItem
        
        tabBar.unselectedItemTintColor = Styles.Colors.base1
        tabBar.tintColor = Styles.Colors.base1
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
                                                    selectedImage: tab.selectedImage,
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
