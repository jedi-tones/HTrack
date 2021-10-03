//
//  AddFriendViewController+Sheet.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

extension AddFriendViewController {
    func setupDrawerView() {
        drawerView.enabledState = [.dismissed, .top]
        drawerView.setHeader(view: drawerHeaderView)
        drawerView.setHeader(view: addFriendHeaderView)
        drawerView.addListener(self)
        
        let headerHeight = drawerView.headerHeight +
                drawerHeaderView.calculatedSize.height +
                addFriendHeaderView.smallestCalculatedConstraintsSize.height +
                Styles.Sizes.stadartVInset
        
        drawerView.maxDrawerPosition = headerHeight
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
            self?.drawerView.setDrawerPosition(.custom(height: headerHeight), animated: true, fastUpdate: false) {}
        }
        
        
//        drawerView.drawerContentView = outputRequestsContentView
//        drawerView.scrollableContent = outputRequestsContentView
//        
//        var contentInset = outputRequestsContentView.contentInset
//        contentInset.top = drawerView.headerHeight +
//        drawerHeaderView.calculatedSize.height +
//        addFriendHeaderView.smallestCalculatedConstraintsSize.height +
//        Styles.Sizes.stadartVInset
//        
//        outputRequestsContentView.contentInset = contentInset
        
        
    }
}

extension AddFriendViewController: DrawerViewListener {
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
