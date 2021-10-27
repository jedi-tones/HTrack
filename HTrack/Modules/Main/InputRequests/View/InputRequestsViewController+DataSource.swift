//
//  FriendsViewController+DataSource.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import UIKit

extension InputRequestsViewController {
    func setupDataSource() {
        guard let collectionView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {[weak self] collectionView, indexpath, item -> UICollectionViewCell? in
                
                guard let vm = item as? CellViewModel else { return nil }
                
                let cell = self?.setupReuseCell(collectionView: collectionView,
                                                indexPath: indexpath,
                                                vm: vm)
                return cell
            })
        
        dataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            
            guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[indexPath.section],
                  kind == UICollectionView.elementKindSectionHeader,
                  let headerVM = sectionModel.header
            else { return self?.setupEmptySectionHeader(collectionView: collectionView, indexPath: indexPath, kind: kind) }
            let headerReuseView = self?.setupSectionHeader(collectionView: collectionView,
                                                           indexPath: indexPath,
                                                           headerVM: headerVM,
                                                           kind: kind)
            
            return headerReuseView
        }
    }
    
    private func setupReuseCell(collectionView: UICollectionView,
                                indexPath: IndexPath,
                                vm: CellViewModel) -> UICollectionViewCell {
        collectionView.register(vm.cell, forCellWithReuseIdentifier: vm.cell.reuseID)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vm.cell.reuseID,
                                                            for: indexPath) as? BaseCellProtocol
        else { return UICollectionViewCell() }
        
        cell.configure(viewModel: vm)
        return cell as? UICollectionViewCell ?? UICollectionViewCell()
    }
    
    private func setupSectionHeader(collectionView: UICollectionView,
                                    indexPath: IndexPath,
                                    headerVM: CellViewModel,
                                    kind: String)  -> UICollectionReusableView? {
        collectionView.register(headerVM.cell,
                                forSupplementaryViewOfKind: kind,
                                withReuseIdentifier: headerVM.cell.reuseID)
        
        if let reuseSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                    withReuseIdentifier: headerVM.cell.reuseID,
                                                                                    for: indexPath) as? BaseCellProtocol {
            
            reuseSectionHeader.configure(viewModel: headerVM)
            return reuseSectionHeader as? UICollectionReusableView
        } else {
            return nil
        }
    }
    
    private func setupEmptySectionHeader(collectionView: UICollectionView,
                                         indexPath: IndexPath,
                                         kind: String)  -> UICollectionReusableView? {
        collectionView.register(EmptyHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: EmptyHeaderCell.reuseID)
        
        guard let reuseSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                       withReuseIdentifier: EmptyHeaderCell.reuseID,
                                                                                       for: indexPath) as? EmptyHeaderCell else { return nil }
        return reuseSectionHeader
    }
}

