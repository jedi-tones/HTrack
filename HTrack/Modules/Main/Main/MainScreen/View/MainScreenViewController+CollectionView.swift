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
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = backColor
        collectionView?.delegate = self
        setupDataSource()
    }
    
    private func setupInfoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 100,
                                                        leading: 20,
                                                        bottom: 0,
                                                        trailing: 20)
        let header = configureHeaderLayout()
    
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    //MARK: setupLayout
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, environment -> NSCollectionLayoutSection? in
            
            guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[section]
            else { fatalError("Unknow section model")}
            guard let section = MainScreenSection(rawValue: sectionModel.section)
            else { fatalError("Unknow section")}
            
            switch section {
            
            case .info:
                return self?.setupInfoSection()
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
