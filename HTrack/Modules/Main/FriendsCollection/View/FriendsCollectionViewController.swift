//  Created by Denis Shchigolev on 27/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints
import Combine

class FriendsCollectionViewController: UIViewController {
    // MARK: Properties
    var output: FriendsCollectionViewOutput?
    var collectionView: UICollectionView?
    var layout: UICollectionViewLayout?
    var dataSource: UICollectionViewDiffableDataSource<SectionViewModel, AnyHashable>?
    
    private var cancelleble: Set<AnyCancellable> = []
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewIsReady()
    }
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

extension FriendsCollectionViewController {
    // MARK: Methods
    func setupViews() {
        
        setupCollectionView()
        setupConstraints()
    }
    
    func setupConstraints() {
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
    func setupSubscriptions() {
        output?.viewModelPublisher
            .throttle(for: .seconds(0.5), scheduler: DispatchQueue.main, latest: true)
            .sink(receiveValue: {[weak self] sectionVM in
                self?.setupData(newData: sectionVM)
            })
            .store(in: &cancelleble)
    }
}

// MARK: - FriendsCollectionViewInput
extension FriendsCollectionViewController: FriendsCollectionViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        setupViews()
    }
    
    func setupData(newData: [SectionViewModel]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) \(newData)")
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionViewModel, AnyHashable>()
        
        newData.forEach { sectionVM in
            var vms: [AnyHashable] = []
            sectionVM.items.forEach { cellViewModel in
                
                switch cellViewModel {
                case let vm as FriendViewModel:
                    vms.append(vm)
                    
                default:
                    break
                }
            }
            
            snapshot.appendSections([sectionVM])
            snapshot.appendItems(vms, toSection: sectionVM)
        }
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(snapshot)
        }
    }
}

extension FriendsCollectionViewController {
    var backColor: UIColor {
        Styles.Colors.base1
    }
}
