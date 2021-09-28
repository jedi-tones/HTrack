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
                                              heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Styles.Sizes.standartHInset,
                                                        leading: Styles.Sizes.standartHInset,
                                                        bottom: Styles.Sizes.bigVInset,
                                                        trailing: Styles.Sizes.standartHInset)
        section.interGroupSpacing = Styles.Sizes.stadartVInset
        let header = configureHeaderLayout()
    
        section.boundarySupplementaryItems = [header]
        
//        let backItem = configureBackgoundItem
//        section.decorationItems = [backItem]
        
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
        
        layout.register(BackgroudSectionView.self, forDecorationViewOfKind: "background")
        
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
    
    private func configureBackgoundItem() -> NSCollectionLayoutDecorationItem{
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        let backgroundInset: CGFloat = .zero
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset,
                                                               leading: backgroundInset,
                                                               bottom: backgroundInset,
                                                               trailing: backgroundInset)
        
        return backgroundItem
    }
}
