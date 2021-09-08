//  Created by Denis Shchigolev on 14/06/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class RegisterInteractor {
    weak var output: RegisterInteractorOutput!

    let userManager = UserManager.shared
    let appManager = AppManager.shared
    
    var currentUser: MUser? {
        userManager.currentUser
    }
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
}

// MARK: - RegisterInteractorInput
extension RegisterInteractor: RegisterInteractorInput {
    func checkNickName(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.checkNicknameIsExist(nickname: name) {[weak self] result in
            switch result {
                
            case .success(let isExist):
                self?.output.nicknameState(isExist: isExist)
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) : \(error)")
            }
        }
    }
    
    func saveNickname(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard
            let currentUser = currentUser
        else {
            Logger.show(title: "Module ERROR",
                           text: "\(type(of: self)) - \(#function) currentUser is NIL")
            return
        }
        let currentUserID = currentUser.userID
        let dic = [MUser.CodingKeys.name : name]
        userManager.updateUser(userID: currentUserID,
                               dic: dic) {[weak self] result in
            switch result {
            
            case .success(_):
                self?.saveNicknameToStore(nickname: name, userID: currentUserID)
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                               text: "\(type(of: self)) - \(#function) \(error)")
                self?.output.saveError(error: error)
            }
        }
    }
    
    func saveNicknameToStore(nickname: String,
                             userID: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        userManager.saveNickName(nickname: nickname,
                                 userID: userID) {[weak self] result in
            switch result {
            
            case .success(_):
                self?.output.nicknameIsUpdated()
            case .failure(let error):
                self?.output.saveError(error: error)
            }
        }
    }
    
    func setAutoCheckFullFillProfile() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        appManager.needAutoCheckProfileFullFilled = true
    }
}
