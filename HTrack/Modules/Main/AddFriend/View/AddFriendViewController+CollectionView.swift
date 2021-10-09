//
//  AddFriendViewController+CollectionView.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import UIKit

extension AddFriendViewController {
    func setupCollectionView() {
        let collectionLayout = setupLayout()
        self.layout = collectionLayout
        
        outputRequestsCollectionView = OutputRequestCollectionView(frame: view.bounds,
                                                                   collectionViewLayout: collectionLayout)
        setupDataSource()
    }
    
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, environment -> NSCollectionLayoutSection? in
            
            guard let sectionModel = self?.diffableDataSource?.snapshot().sectionIdentifiers[section],
                  let section = OutputRequestSection(rawValue: sectionModel.section)
            else { return nil }
            
            switch section {
                
            case .ouputRequest:
                return self?.ouputRequestSection()
                
            }
        }
        return layout
    }
    
    private func ouputRequestSection() -> NSCollectionLayoutSection {
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
        section.visibleItemsInvalidationHandler = {[weak self] (items, offset, environment) in
            
        }
        section.boundarySupplementaryItems = [header]
        
        return section
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
