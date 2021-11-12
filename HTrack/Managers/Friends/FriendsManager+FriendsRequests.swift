//
//  FriendsManager+FriendsRequests.swift
//  HTrack
//
//  Created by Jedi Tones on 10/20/21.
//

import Foundation

extension FriendsManager {
    ///Проверяет можем ли добавить юзера в друзья
    ///
    ///Сначала проверяется на существование друга.
    ///Затем не забанил ли юзер тебя.
    ///Если юзера можем добавить, то complition == MUser, где MUser - добавляемый друг , иначе ошибка
    func checkCanAddFriendRequest(userName: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.checkCanAddFriendRequest(userName: userName, complition: complition)
    }
    
    ///Отправлят заявку в друзья
    ///
    ///Использовать в случае если нет входящей заявки от юзера
    func sendAddFriendRequst(currentMUser: MUser, toUser: MUser?, userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        friendsRequestManager.sendAddFriendRequst(currentMUser: currentMUser,
                                             toUser: toUser,
                                                  userID: userID) { [weak self] result in
            switch result {
                
            case .success(let mUser):
                complition?(.success(mUser))
                
                if let friendFCMKey = mUser.fcmKey,
                   let currentUser = self?.userManager.currentUser {
                    self?.pushFCMManager.sendNewInputRequest(to: friendFCMKey, sender: currentUser)
                }
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///Принимаем запрос от друга
    ///
    ///После идет добавление друга в коллекцию друзей
    func acceptInputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.acceptInputRequest(userID: userID) {[weak self] result in
            switch result {
                
            case .success(let mUser):
                complition?(.success(mUser))
                
                if let friendFCMKey = mUser.fcmKey,
                   let currentUser = self?.userManager.currentUser {
                    self?.pushFCMManager.sendUserAdded(to: friendFCMKey, sender: currentUser)
                }
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///Отклоняем запрос от друга и уведомляем его об этом
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        friendsRequestManager.rejectInputRequest(userID: userID) { [weak self] result in
            switch result {
                
            case .success(let mUser):
                complition?(.success(mUser))
                
                if let friendFCMKey = mUser.fcmKey,
                   let currentUser = self?.userManager.currentUser {
                    self?.pushFCMManager.sendRejectRequest(to: friendFCMKey, sender: currentUser)
                }
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///отклоняем исходящую заявку
    func rejectOutputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.rejectOutputRequest(userID: userID, complition: complition)
    }
    
    ///удаляем друга
    func removeFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.removeFriend(userID: userID) {[weak self] result in
            switch result {
                
            case .success(let mUser):
                complition?(.success(mUser))
                
                if let friendFCMKey = mUser.fcmKey,
                   let currentUser = self?.userManager.currentUser {
                    self?.pushFCMManager.sendDeleteFriend(to: friendFCMKey, sender: currentUser)
                }
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///обновляем дату с которой не пьем у друзей
    func updateStartDateInFriends(startDay: Double, complition: @escaping(Result<Bool, Error>) -> Void) {
        let friendsIDS = friendsP.map({$0.userID})
        friendsRequestManager.updateStartDateInFriends(friendsIDs: friendsIDS, startDay: startDay, complition: complition)
        
        guard let currentUser = userManager.currentUser,
              startDay.fromUNIXTimestampToDate().isToday() else { return }
        let friendsFCMs = friendsP.compactMap({$0.fcmKey})
        pushFCMManager.iDrink(to: friendsFCMs, sender: currentUser)
    }
    
    
    /// обновление FCM токена у дрезей в их списке друзей
    /// - Parameters:
    ///   - token: FCM токен текущего пользователя
    ///   - complition: комплишен
    func updateFCMTokenInFriends(token: String, complition: @escaping(Result<Bool, Error>) -> Void) {
        let friendsIDS = friendsP.map({$0.userID})
        
        friendsRequestManager.updateFCMTokenInFriends(friendsIDs: friendsIDS, token: token, complition: complition)
    }
}
