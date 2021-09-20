//
//  FriendsViewController+CollectionView.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

extension FriendsViewController {
    func setupCollectionView() {
        let collectionLayout = setupLayout()
        self.layout = collectionLayout
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
        collectionView?.backgroundColor = backColor
        collectionView?.delegate = self
        setupDataSource()
    }
    
    private func setupFriendsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 16,
                                                        bottom: 20,
                                                        trailing: 16)
        section.interGroupSpacing = Styles.Sizes.stadartVInset
        
        let header = configureHeaderLayout()
    
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    //MARK: setupLayout
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, environment -> NSCollectionLayoutSection? in
            
            guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[section],
                  let section = FriendsScreenSection(rawValue: sectionModel.section)
            else { return nil }
            
            switch section {
            
            case .inputRequest:
                return self?.setupFriendsSection()
            
            case .friends:
                return self?.setupFriendsSection()
            }
        }
        return layout
    }
    
    private func configureHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem  {
        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .estimated(1))
        
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        
        return item
    }
}
