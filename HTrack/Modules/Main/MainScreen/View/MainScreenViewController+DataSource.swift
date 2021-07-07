//
//  MainScreenViewController+DataSource.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

extension MainScreenViewController {
    func setupDataSource() {
        guard let collectionView = collectionView else { fatalError("collectionView is nil") }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {[weak self] collectionView, indexpath, item -> UICollectionViewCell? in
                
                guard let sectionID = self?.dataSource?.snapshot().sectionIdentifiers[indexpath.section] else { fatalError("Unknown section")}
        
                switch sectionID {
                
                case _ where sectionID == MainScreenSection.info.rawValue:
                    guard let vm = item as? CellViewModel else { fatalError("Unknown cell VM") }
                    
                    let cell = self?.setupReuseCell(collectionView: collectionView,
                                   indexPath: indexpath,
                                   vm: vm)
                    return cell
                    
                default:
                    return UICollectionViewCell()
                }
            })
    }
    
    private func setupReuseCell(collectionView: UICollectionView,
                                indexPath: IndexPath,
                                vm: CellViewModel) -> UICollectionViewCell {
        collectionView.register(vm.cell, forCellWithReuseIdentifier: vm.cell.reuseID)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vm.cell.reuseID,
                                                            for: indexPath) as? BaseCell else { fatalError("can't get cell")}
        cell.configure(viewModel: vm)
        return cell as? UICollectionViewCell ?? UICollectionViewCell()
    }
}

