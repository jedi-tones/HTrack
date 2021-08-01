//
//  UINavigationController+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 6/14/21.
//

import UIKit

extension UINavigationController {
    func setupNavigationController(image: UIImage? = nil,
                                   title: String? = nil,
                                   tag: Int? = nil,
                                   isHidden: Bool = false,
                                   withoutBackImage: Bool = false) {
        
        if let tag = tag {
            self.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tabBarItem.image = image
            self.tabBarItem.tag = tag
        }
        
        self.navigationItem.title = title
        self.navigationBar.isHidden = isHidden
        
        let appereance = self.navigationBar.standardAppearance.copy()
        appereance.shadowImage = UIImage()
        appereance.shadowColor = .clear
        appereance.backgroundImage = UIImage()
        appereance.backgroundColor = Styles.Colors.myWhiteColor()
        
        self.navigationBar.standardAppearance = appereance
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.tintColor = Styles.Colors.myLabelColor()
        
        self.navigationBar.titleTextAttributes = [.font: Styles.Fonts.AvenirFonts.avenirNextBold(size: 16)]
        self.navigationBar.largeTitleTextAttributes = [.font: Styles.Fonts.AvenirFonts.avenirNextBold(size: 38)]
    }
}
