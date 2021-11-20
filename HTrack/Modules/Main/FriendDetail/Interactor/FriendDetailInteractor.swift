//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendDetailInteractor {
    weak var output: FriendDetailInteractorOutput!

    lazy var friendsManager = FriendsManager.shared
    lazy var pushFCMManager = PushFCMManager.shared
    lazy var userManager = UserManager.shared
    lazy var popUpManager = PopUpManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    private var friend: MUser?
    private var requestUser: MRequestUser?
    
    var friendDayCount: Int {
        return friend?.startDate?.getDayCount() ?? 0
    }
    
    var friendName: String {
        return friend?.name ?? requestUser?.nickname ?? "Name"
    }
}

// MARK: - FriendDetailInteractorInput
extension FriendDetailInteractor: FriendDetailInteractorInput {
    func getModuleElements() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        if friend != nil {
            let elements = FriendsDetailElement.allCases
            output.setupModule(elements: elements)
        } else if requestUser != nil {
            let elements = FriendsInputRequestElement.allCases
            output.setupRequestModule(elements: elements)
        } else {
            output.needCloseModule()
        }
    }
    
    func setFriend(friend: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        self.friend = friend
    }
    
    func setRequest(request: MRequestUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        self.requestUser = request
    }
    
    func removeFriend() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let friend = friend else { return }
        friendsManager.removeFriend(userID: friend.userID) {[weak self] result in
            switch result {
                
            case .success(_):
                self?.output?.needCloseModule()
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error - \(error)")
                self?.output?.needCloseModule()
            }
        }
    }
    
    func acceptRequest() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let requestUserID = requestUser?.userID else { return }
        friendsManager.acceptInputRequest(userID: requestUserID) {[weak self] result in
            switch result {
                
            case .success(_):
                self?.output?.needCloseModule()
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error - \(error)")
                self?.output?.needCloseModule()
            }
        }
    }
    
    func rejectRequest() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let requestUserID = requestUser?.userID else { return }
        friendsManager.rejectInputRequest(userID: requestUserID) {[weak self] result in
            switch result {
                
            case .success(_):
                self?.output?.needCloseModule()
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) error - \(error)")
                self?.output?.needCloseModule()
            }
        }
    }
    
    func sendReactionToFriend() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let currentUser = userManager.currentUser,
              let friend = friend,
              let friendToken = friend.fcmKey
        else { return }
       
        pushFCMManager.sendReactionToFriend(token: friendToken, sender: currentUser)
        popUpManager.showInfo(text: "Мы отправили лучи поддержки твоему другу")
    }
}
