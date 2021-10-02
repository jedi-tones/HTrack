//
//  FriendDetailViewController+Sheet.swift
//  HTrack
//
//  Created by Jedi Tones on 10/3/21.
//

import UIKit

extension FriendDetailViewController {
    func setupDrawerView() {
        drawerView.drawerContentView = friendDetailContentView
        drawerView.scrollableContent = friendDetailContentView
        drawerView.enabledState = [.dismissed]
        drawerView.setHeader(view: drawerHeaderView)
        drawerView.addListener(self)
        
        var contentInset = friendDetailContentView.contentInset
        contentInset.top = drawerView.headerHeight + drawerHeaderView.calculatedSize.height + Styles.Sizes.stadartVInset
        
        friendDetailContentView.contentInset = contentInset
        
        friendDetailContentView.didChangeContentSize = {[weak self] size in
            guard let self = self else { return }
            
            var h = size.height + contentInset.top + Styles.Sizes.safeAreaInsets.bottom
            
            let minHeight = Styles.Sizes.minHeightDrawerView + Styles.Sizes.safeAreaInsets.bottom
            if h < minHeight {
                h = minHeight
            }
            
            
            if h <= self.drawerView.maxHeight {
                self.drawerView.maxDrawerPosition = h
            } else {
                h = self.drawerView.maxHeight
            }
            
            self.drawerView.setDrawerPosition(.custom(height: h), animated: true) {}
        }
    }
}

extension FriendDetailViewController: DrawerViewListener {
    func drawerView(_ drawerView: DrawerView, willBeginAnimationToState state: DrawerView.State?) {
        
    }
    
    func drawerView(_ drawerView: DrawerView, didEndAnimationToState state: DrawerView.State?) {
        switch state {
        case .dismissed:
            output.didDismissedSheet()
            break

        default:
            break
        }
    }
}
