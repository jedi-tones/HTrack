//  Created by Denis Shchigolev on 15/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Foundation

class MainScreenPresenter {
    weak var output: MainScreenModuleOutput?
    weak var view: MainScreenViewInput!
    var router: MainScreenRouterInput!
    var interactor: MainScreenInteractorInput!
    
    var viewModel: [SectionViewModel] = []
    var timer: Timer?
    var currentCount: Int?
    var startDate: Date?
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    func viewIsReady() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")

        view.setupInitialState()
        _ = interactor.getUser()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {[weak self] in
            self?.interactor.requestAppTrackingPermission()
        }
    }
    
    func setupUpdateTimer() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        if timer == nil {
            let timeInterval = TimeInterval(60)
            timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(mainScreenTimerTick), userInfo: nil, repeats: true)
            timer?.tolerance = 30
            if let timer = timer {
                RunLoop.main.add(timer, forMode: .common)
            }
        }
    }
    
    func drinkButtonTapped() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        interactor?.resetDrinkDate()
    }
    
    func needUpdateDate() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        updateMainScreen()
    }
    
    @objc private func mainScreenTimerTick() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        updateMainScreen()
    }
}

// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {
    func updateUserStat(user: MUser?) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        startDate = user?.startDate
        updateMainScreen()
        setupUpdateTimer()
    }
    
    private func updateMainScreen() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let startDate = startDate else { return }
        
        let count = String(startDate.getDayCount())
        
        let daysCountString = LocDic.daysWithoutAlcohol.withArguments([count]).replacingOccurrences(of: " ", with: "\n")
        let infoVM = MainScreenInfoViewModel(title: daysCountString,
                                             count: count)
        
        view.update(vm: infoVM)
    }
}

// MARK: - MainScreenModuleInput
extension MainScreenPresenter: MainScreenModuleInput {
    func configure(output: MainScreenModuleOutput) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        self.output = output
    }
}
