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
        drawerView.drawerContentView = outputRequestsCollectionView
        drawerView.scrollableContent = outputRequestsCollectionView
        drawerView.addListener(self)
        
        let headerHeight = drawerView.headerHeight +
                drawerHeaderView.calculatedSize.height +
                addFriendHeaderView.smallestCalculatedConstraintsSize.height +
                Styles.Sizes.stadartVInset
        
        var contentInset = outputRequestsCollectionView?.contentInset ?? .zero
        contentInset.top = headerHeight + Styles.Sizes.stadartVInset
        outputRequestsCollectionView?.contentInset = contentInset
        
        outputRequestsCollectionView?.didChangeContentSize = {[weak self] size in
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
        
//        drawerView.maxDrawerPosition = headerHeight
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
//            self?.drawerView.setDrawerPosition(.custom(height: headerHeight), animated: true, fastUpdate: false) {}
//        }
        
    }
}

extension AddFriendViewController: DrawerViewListener {
    func drawerView(_ drawerView: DrawerView, willBeginAnimationToState state: DrawerView.State?) {
        
    }
    
    func drawerView(_ drawerView: DrawerView, didEndAnimationToState state: DrawerView.State?) {
        switch state {
        case .dismissed:
            output?.didDismissedSheet()
            break

        default:
            break
        }
    }
    
    
}