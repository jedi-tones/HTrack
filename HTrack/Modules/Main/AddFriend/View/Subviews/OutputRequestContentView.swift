//
//  OutputRequestContentView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/3/21.
//

import UIKit

class OutputRequestContentView: UICollectionView, ScrollableContent {
    var didChangeContentSize: ((_ size: CGSize) -> ())?
    var scrollViewDelegate: UIScrollViewDelegate?

    func scrollToTop() {}
    
    
}

extension OutputRequestContentView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
}
