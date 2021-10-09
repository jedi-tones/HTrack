//
//  OutputRequestCollectionView.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import UIKit

class OutputRequestCollectionView: UICollectionView, ScrollableContent {
    var didChangeContentSize: ((_ size: CGSize) -> ())?
    var scrollViewDelegate: UIScrollViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = backColor
    }
    
    func scrollToTop() {}
}

extension OutputRequestCollectionView {
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

extension OutputRequestCollectionView {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
}
