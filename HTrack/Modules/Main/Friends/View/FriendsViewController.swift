//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class FriendsViewController: UIViewController {
    // MARK: Properties
    var output: FriendsViewOutput!
    
    var collectionView: UICollectionView?
    var layout: UICollectionViewLayout?
    var dataSource: UICollectionViewDiffableDataSource<SectionViewModel, AnyHashable>?
    
    lazy var rightSettingsButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Styles.Images.settingButtonImage,
                                   style: .plain,
                                   target: self,
                                   action: #selector(settingsButtonTapped(sender:)))
        return item
    }()
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    @objc private func settingsButtonTapped(sender: UIBarButtonItem) {
        output.settingsButtonTapped()
    }
}

extension FriendsViewController {
    // MARK: Methods
    func setupViews() {
        view.backgroundColor = backColor
        
        navigationController?.navigationBar.backgroundColor = Styles.Colors.myBackgroundColor()
        navigationItem.rightBarButtonItem = rightSettingsButton
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupCollectionView()
        setupConstraints()
    }

    func setupConstraints() {
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - FriendsViewInput
extension FriendsViewController: FriendsViewInput {
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
                    
                case let vm as FriendInputRequestViewModel:
                    vms.append(vm)
                default:
                    break
                }
            }
            
            snapshot.appendSections([sectionVM])
            snapshot.appendItems(vms, toSection: sectionVM)
        }
        dataSource?.apply(snapshot)
    }
    
    func updateNickname(nickName: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        DispatchQueue.main.async {[weak self] in
            self?.navigationItem.title = "@\(nickName.uppercased())"
        }
    }
}

extension FriendsViewController {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
}
