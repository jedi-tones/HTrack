//
//  MainScreenViewController+CollectionView.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

extension MainScreenViewController {
    
    func setupCollectionView() {
        let collectionLayout = setupLayout()
        self.layout = collectionLayout
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
        
        collectionView?.backgroundColor = Colors.myWhiteColor()
        collectionView?.delegate = self
        setupDataSource()
    }
    
    private func setupInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 20,
                                                        bottom: 0,
                                                        trailing: 20)
        
        return section
    }
    
    //MARK: setupLayout
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, environment -> NSCollectionLayoutSection? in
            
            guard let sectionID = self?.dataSource?.snapshot().sectionIdentifiers[section] else { fatalError("Unknow section")}
            
            if sectionID == MainScreenSection.info.rawValue {
                return self?.setupInfoSection()
            } else {
                return nil
            }
        }
        return layout
    }
}
