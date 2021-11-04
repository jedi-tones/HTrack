//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

import Dispatch
import Combine

class AddFriendInteractor {
    weak var output: AddFriendInteractorOutput?
    var friendsManager = FriendsManager.shared
    var userManager = UserManager.shared
    
    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.unsubscribeOutputRequestsListner()
    }
}

// MARK: - AddFriendInteractorInput
extension AddFriendInteractor: AddFriendInteractorInput {
    func outputRequestsPublisher() -> AnyPublisher<[MRequestUser], Never> {
        try? friendsManager.subscribeOutputRequestsListner()
        return friendsManager.outputRequestsRequestsPublisher.eraseToAnyPublisher()
    }
    
    func sendAddFriendAction(name: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        guard let currentMUser = userManager.currentUser else { return }
        let nameToAdd = name.uppercased()
        //если у нас уже есть входящая заявка, то принимаем ее и закрываем пикер
        if let requestUser = friendsManager.inputRequestsP.filter({$0.nickname?.uppercased() == nameToAdd}).first {
            friendsManager.acceptInputRequest(userID: requestUser.userID) {[weak self] result in
                switch result {
                    
                case .success(_):
                    self?.output?.needCloseSheet()
                case .failure(let error):
                    Logger.show(title: "Module ERROR",
                                text: "\(type(of: self)) - \(#function) \(error)")
                }
            }
        } else {
            //иначе проверяем можем ли мы вообще добавить челика в друзья
            //вдруг его не существует или он нас забанил
            DispatchQueue.global().async {
                self.friendsManager.checkCanAddFriendRequest(userName: nameToAdd) {[weak self] result in
                    switch result {
                        
                    case .success(let mUser):
                        //можем добавить, отправляем запрос
                        self?.friendsManager.sendAddFriendRequst(currentMUser: currentMUser,
                                                                 toUser: mUser,
                                                                 userID: mUser.userID,
                                                                 complition: { result in
                            switch result {
                                
                            case .success(_):
                                self?.output?.addComplite()
                            case .failure(let error):
                                Logger.show(title: "Module ERROR",
                                            text: "\(type(of: self)) - \(#function) \(error)")
                                self?.output?.showAddFriendError(error: error.localizedDescription)
                            }
                        })
                    case .failure(let error):
                        Logger.show(title: "Module ERROR",
                                    text: "\(type(of: self)) - \(#function) \(error)")
                        self?.output?.showAddFriendError(error: error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    func getOuputRequestSections() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let sections:[OutputRequestSection] = [.ouputRequest]
        output?.setupSections(sections: sections)
    }
    
    func cancelRequestFor(id: String) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        friendsManager.rejectOutputRequest(userID: id) { result in
            switch result {
                
            case .success(_):
                break
            case .failure(let error):
                Logger.show(title: "Module ERROR",
                            text: "\(type(of: self)) - \(#function) \(error)")
            }
        }
    }
}
