//
//  MainScreenViewController+DataSource.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

extension MainScreenViewController {
    func setupDataSource() {
        guard let collectionView = collectionView else { return }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {[weak self] collectionView, indexpath, item -> UICollectionViewCell? in
                
                guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[indexpath.section]
                else { return nil }
                guard let section = MainScreenSection(rawValue: sectionModel.section)
                else { return nil }
        
                switch section {
                
                case .info:
                    guard let vm = item as? CellViewModel else { fatalError("Unknown cell VM") }
                    
                    let cell = self?.setupReuseCell(collectionView: collectionView,
                                                    indexPath: indexpath,
                                                    vm: vm)
                    return cell
                }
            })
        
        dataSource?.supplementaryViewProvider = {
            [weak self] collectionView, kind, indexPath in
            
            guard let sectionModel = self?.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            else { fatalError("Unknown section")}
            if let headerVM = sectionModel.header {
                let headerReuseView = self?.setupSectionHeader(collectionView: collectionView,
                                                               indexPath: indexPath,
                                                               headerVM: headerVM,
                                                               kind: kind)
                
                return headerReuseView
            } else {
                return  self?.setupEmptySectionHeader(collectionView: collectionView,
                                                      indexPath: indexPath,
                                                      kind: kind)
            }
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
                                                                                 for: indexPath) as? EmptyHeaderCell else { fatalError("can't get cell")}
        return reuseSectionHeader
    }
}

