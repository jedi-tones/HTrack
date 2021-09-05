//
//  SettingsViewController+CollectionVIew.swift
//  HTrack
//
//  Created by Jedi Tones on 9/3/21.
//

import UIKit

extension SettingsViewController {
    func setupCollectionView() {
        let collectionLayout = setupLayout()
        self.layout = collectionLayout
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = backColor
        collectionView?.delegate = self
        setupDataSource()
    }
    
    private func setupBaseSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(10))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(Styles.Sizes.baseVInset)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: .zero,
                                                        leading: Styles.Sizes.baseHInset,
                                                        bottom: .zero,
                                                        trailing: Styles.Sizes.baseHInset)
        let header = configureHeaderLayout()
    
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    //MARK: setupLayout
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, environment -> NSCollectionLayoutSection? in
            
            guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[section]
            else { fatalError("Unknow section model")}
            guard let section = SettingsSection(rawValue: sectionModel.section)
            else { fatalError("Unknow section")}
            
            switch section {
            
            case .control:
                return self?.setupBaseSection()
            case .info:
                return self?.setupBaseSection()
            case .settings:
                return self?.setupBaseSection()
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
