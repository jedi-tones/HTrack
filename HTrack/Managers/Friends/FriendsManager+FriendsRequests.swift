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
                                             userID: userID,
                                             complition: complition)
    }
    
    ///Принимаем запрос от друга
    ///
    ///После идет добавление друга в коллекцию друзей
    func acceptInputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.acceptInputRequest(userID: userID, complition: complition)
    }
    
    ///Отклоняем запрос от друга и уведомляем его об этом
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        friendsRequestManager.rejectInputRequest(userID: userID, complition: complition)
    }
    
    func rejectOutputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.rejectOutputRequest(userID: userID, complition: complition)
    }
    
    func removeFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        friendsRequestManager.removeFriend(userID: userID, complition: complition)
    }
    
    func updateStartDateInFriends(startDay: Double, complition: @escaping(Result<Bool, Error>) -> Void) {
        let friendsIDS = friendsP.map({$0.userID})
        friendsRequestManager.updateStartDateInFriends(friendsIDs: friendsIDS, startDay: startDay, complition: complition)
    }
}
