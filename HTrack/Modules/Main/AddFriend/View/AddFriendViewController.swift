//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class AddFriendViewController: UIViewController {
    // MARK: Properties
    var output: AddFriendViewOutput?
    var diffableDataSource: UICollectionViewDiffableDataSource<SectionViewModel, AnyHashable>?
    var layout: UICollectionViewLayout?
    var outputRequestsCollectionView: OutputRequestCollectionView?
    var drawerView = DrawerView()
    var keyboardHeight: CGFloat = .zero
    
    lazy var drawerHeaderView: DrawerTextHeaderView = {
        let header = DrawerTextHeaderView()
        header.setTitle(title: "добавить друга".uppercased())
        header.setFont(font: Styles.Fonts.bold2)
        header.onClose = { [weak self] in
            _ = self?.addFriendHeaderView.addFriendInput.resignFirstResponder()
            self?.drawerView.setDrawerPosition(.dismissed,
                                         animated: true,
                                         fastUpdate: false) {}
        }
        return header
    }()
    
    lazy var addFriendHeaderView: AddFriendHeaderView = {
        let hv = AddFriendHeaderView()
        hv.updateState(to: .normal)
        hv.addFriendAction = {[weak self] friendName in
            self?.output?.addFriendAction(name: friendName)
        }
        return hv
    }()
    
    fileprivate lazy var keyboardNotification: KeyboardNotifications = {
        let kn = KeyboardNotifications(notifications: [.willShow, .didHide], delegate: self)
        return kn
    }()
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.viewIsReady()
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
        
        keyboardNotification.isEnabled = false
    }
}

extension AddFriendViewController {
    // MARK: Methods
    func setupViews() {
        
        keyboardNotification.isEnabled = true
        setupCollectionView()
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDuarationBase) { [weak self] in
            self?.setupDrawerView()
        }
    }

    func setupConstraints() {
        view.addSubview(drawerView)
        drawerView.edgesToSuperview()
    }
}

// MARK: - AddFriendViewInput
extension AddFriendViewController: AddFriendViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
    
    func setupState(state: AddFriendHeaderView.AddFriendHeaderState) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) state: \(state)")
        
        DispatchQueue.main.async {[weak self] in
            self?.addFriendHeaderView.updateState(to: state)
        }
    }
    
    func setupData(newData: [SectionViewModel]) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) \(newData)")
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionViewModel, AnyHashable>()
        
        newData.forEach { sectionVM in
            var vms: [AnyHashable] = []
            sectionVM.items.forEach { cellViewModel in
                
                switch cellViewModel {
                case let vm as FriendOutputRequestViewModel:
                    vms.append(vm)
                default:
                    break
                }
            }
            
            snapshot.appendSections([sectionVM])
            snapshot.appendItems(vms, toSection: sectionVM)
        }
        diffableDataSource?.apply(snapshot,
                                  animatingDifferences: true,
                                  completion: {[weak self] in
            let contentSize = self?.outputRequestsCollectionView?.contentSize ?? .zero
            self?.outputRequestsCollectionView?.didChangeContentSize?(contentSize, self?.keyboardHeight ?? .zero)
        })
    }
    
    func closeDrawerView() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        drawerView.setDrawerPosition(.dismissed) { [weak self] in
            self?.output?.closeModule()
        }
    }
}

extension AddFriendViewController: KeyboardNotificationsDelegate {
    func keyboardWillShow(notification: NSNotification) {
        let keyboardInfo = KeyboardPayload(notification)
        
        guard keyboardInfo?.frameEnd.size.height ?? 0 > .zero else { return }
        if let keyboardH = keyboardInfo?.frameEnd.size.height {
            keyboardHeight = keyboardH
            let contentSize = outputRequestsCollectionView?.contentSize ?? .zero
            outputRequestsCollectionView?.didChangeContentSize?(contentSize, keyboardHeight)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        keyboardHeight = .zero
        let contentSize = outputRequestsCollectionView?.contentSize ?? .zero
        outputRequestsCollectionView?.didChangeContentSize?(contentSize, keyboardHeight)
    }
}
