//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import UIKit
import TinyConstraints

class MainScreenViewController: UIViewController {
    // MARK: Properties
    var output: MainScreenViewOutput!

    lazy var infoView = MainScreenInfoView()
    lazy var backNoiseImageView: UIImageView = {
        let iv = UIImageView(image: Styles.Images.mainScreenNoise)
        
        return iv
    }()
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backColor
        
        navigationController?.navigationBar.isHidden = true
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

extension MainScreenViewController {
    // MARK: Methods
    func setupViews() {
        
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(infoView)
        view.addSubview(backNoiseImageView)
        infoView.centerInSuperview()
        backNoiseImageView.edgesToSuperview(excluding: .bottom)
    }
}

// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
    func setupInitialState() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        setupViews()
    }
    
    func update(vm: MainScreenInfoViewModel) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function) vm: \(vm)")
        
        infoView.setup(vm: vm)
    }
}

extension MainScreenViewController {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
}
