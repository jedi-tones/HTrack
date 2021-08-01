//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit

class WelcomeViewController: UIViewController {
    // MARK: Properties
    var output: WelcomeViewOutput!
    private let welcomView = WelcomeView()
    
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

extension WelcomeViewController {
    // MARK: Methods
    func setupViews() {
        navigationController?.navigationBar.isHidden = true
        
        welcomView.signInWithApple.action = { [weak self] in
            self?.output.signInWithApple()
        }
        welcomView.signInWithEmail.action = { [weak self] in
            self?.output.signInWithEmail()
        }
        
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(welcomView)
        
        welcomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            welcomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - WelcomeViewInput
extension WelcomeViewController: WelcomeViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
}
