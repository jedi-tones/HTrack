//
//  FriendsViewController+NavigationBar.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import UIKit

extension FriendsViewController {
    func setupNavBar() {
        navigationController?.navigationBar.backgroundColor = Styles.Colors.myBackgroundColor()
        navigationItem.leftBarButtonItem = leftNavButton
        navigationItem.rightBarButtonItems = [addFriendNavButton, rightSettingsButton]
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
