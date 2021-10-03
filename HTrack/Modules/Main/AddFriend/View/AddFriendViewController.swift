//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class AddFriendViewController: UIViewController {
    // MARK: Properties
    var output: AddFriendViewOutput!
    
    var drawerView = DrawerView()
    lazy var drawerHeaderView: DrawerTextHeaderView = {
        let header = DrawerTextHeaderView()
        header.setTitle(title: "Добавить друга")
        header.onClose = { [weak self] in
            self?.drawerView.setDrawerPosition(.dismissed,
                                         animated: true,
                                         fastUpdate: false) {}
        }
        return header
    }()
    
    lazy var addFriendHeaderView: AddFriendHeaderView = {
        let hv = AddFriendHeaderView()
        hv.updateState(to: .normal)
        return hv
    }()
    
    lazy var outputRequestsContentView: OutputRequestContentView = {
        let contentView = OutputRequestContentView()
        
        return contentView
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
}

extension AddFriendViewController {
    // MARK: Methods
    func setupViews() {
        setupConstraints()
        setupDrawerView()
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
        
        addFriendHeaderView.updateState(to: state)
    }
}
