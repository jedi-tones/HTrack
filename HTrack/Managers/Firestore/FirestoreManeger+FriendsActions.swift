//
//  FirestoreManeger+FriendsActions.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/10/21.
//

import Foundation
import FirebaseFirestoreSwift

extension FirestoreManager {
    ///Проверяет можем ли добавить юзера в друзья
    ///
    ///Сначала проверяется на существование друга.
    ///Затем не забанил ли юзер тебя.
    ///Если юзера можем добавить, то complition == MUser, где MUser - добавляемый друг , иначе ошибка
    func checkCanAddFriendRequest(userName: String, complition:((Result<MUser,Error>) -> Void)?) {
        //проверяем введенной ник не текущий юзер
        guard let currentUserName = userManager.currentUser?.name
        else {
            complition?(.failure(FirestoreError.unownedError))
            return
        }
        
        guard currentUserName != userName
        else {
            complition?(.failure(FirestoreError.isItYou))
            return
        }
        //проверяем есть ли в друзьях
        guard !friendsManager.friendsP.contains(where: {$0.name == userName})
        else {
            complition?(.failure(FirestoreError.thisUserAlreadyYouFriend))
            return
        }
        //проверяем есть ли исходящая заявка
        guard !friendsManager.outputRequestsP.contains(where: {$0.nickname == userName})
        else {
            complition?(.failure(FirestoreError.alreadyHasOutputRequestToThisUser))
            return
        }
        //проверяем существует ли юзер
        let checkUserExistOperation = BaseAsyncOperationConstructor {[weak self] input, complitionOperation in
            self?.getUser(nickname: userName) { result in
                switch result {
                    
                case .success(let mUser):
                    Logger.show(title: "FirestoreManager: \(#function)", text: "checkUserOperation: \(mUser)")
                    complitionOperation(.success(mUser))
                case .failure(let error):
                    complitionOperation(.failure([error], nil))
                }
            }
        }
        //проверяем не забанил ли тебя юзер
        let checkBannedFromUserOperation = BaseAsyncOperationConstructor {[weak self] input, complitionOperation in
            guard let input = input
            else {
                complitionOperation(.failure([FirestoreError.unownedError], nil))
                return
            }
            
            switch input {
                
            case .success(let inputData):
                if let mUser = inputData as? MUser {
                    self?.checkIsBannedFor(userID: mUser.userID, complition: { result in
                        switch result {
                            
                        case .success(let isBanned):
                            if isBanned {
                                //если забанен выкидываем ошибку
                                complitionOperation(.failure([FirestoreError.userBannedYou], nil))
                            } else {
                                complitionOperation(.success(mUser))
                            }
                        case .failure(let error):
                            complitionOperation(.failure([error], nil))
                        }
                    })
                } else {
                    complitionOperation(.failure([FirestoreError.incorrectInputData], nil))
                }
            case .failure(let error, _):
                complitionOperation(.failure(error, nil))
            }
        }
        
        let operationQueue = COperationQueue()
        operationQueue.qualityOfService = .background
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperations(operations: [checkUserExistOperation, checkBannedFromUserOperation]) { resultOperation in
            if let resultOperation = resultOperation {
                switch resultOperation {
                   
                case .success(let resultData):
                    if let mFrienduser = resultData as? MUser {
                        complition?(.success(mFrienduser))
                    } else {
                        complition?(.failure(FirestoreError.incorrectResultData))
                    }
                case .failure(let error, _):
                    complition?(.failure(error.last ?? FirestoreError.unownedError))
                }
            } else {
                complition?(.failure(FirestoreError.unownedError))
            }
        }
        operationQueue.start()
    }
    
    ///Отправлят заявку в друзья
    ///
    ///Использовать в случае если нет входящей заявки от юзера
    func sendAddFriendRequst(currentMUser: MUser, toUser: MUser?, userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let outputRequestsCollection = FirestoreEndPoint.outputRequests(userID: currentUserID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        guard let inputFriendRequestsCollection = FirestoreEndPoint.inputRequests(userID: userID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        let mInputRequestUser = MRequestUser(nickname: currentMUser.name,
                                             userID: currentMUser.userID,
                                             photo: currentMUser.photo,
                                             fcmKey: currentMUser.fcmKey,
                                             createDate: Date())
        
        if let toUser = toUser {
            let mOutputRequestUser = MRequestUser(nickname: toUser.name,
                                                  userID: toUser.userID,
                                                  photo: toUser.photo,
                                                  fcmKey: toUser.fcmKey,
                                                  createDate: Date())
           
            do {
                try outputRequestsCollection.document(toUser.userID).setData(from: mOutputRequestUser)
                try inputFriendRequestsCollection.document(currentMUser.userID).setData(from: mInputRequestUser)
                sendNotificationToFriend(userToken: mOutputRequestUser.fcmKey,
                                         text: "У тебя новая заявка в друзья от \(mInputRequestUser.nickname ?? "анонима")")
                complition?(.success(mOutputRequestUser))
            } catch {
                complition?(.failure(error))
            }
        } else {
            //если юзера не передали в запрос, сначала получаем его
            getUser(id: userID) {[weak self] result in
                switch result {
                    
                case .success(let toUser):
                    let mOutputRequestUser = MRequestUser(nickname: toUser.name,
                                                          userID: toUser.userID,
                                                          photo: toUser.photo,
                                                          fcmKey: toUser.fcmKey,
                                                          createDate: Date())
                    do {
                        try outputRequestsCollection.document(toUser.userID).setData(from: mOutputRequestUser)
                        try inputFriendRequestsCollection.document(currentMUser.userID).setData(from: mInputRequestUser)
                        self?.sendNotificationToFriend(userToken: mOutputRequestUser.fcmKey,
                                                 text: "У тебя новая заявка в друзья от \(mInputRequestUser.nickname ?? "анонима")")
                        complition?(.success(mOutputRequestUser))
                    } catch {
                        complition?(.failure(error))
                    }
                case .failure(let error):
                    complition?(.failure(error))
                }
            }
        }
    }
    
    ///Принимаем запрос от друга
    ///
    ///После идет добавление друга в коллекцию друзей
    func acceptInputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let inputRequestsCollection = FirestoreEndPoint.inputRequests(userID: currentUserID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        guard let outputFriendRequestsCollection = FirestoreEndPoint.outputRequests(userID: userID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        //удаляем входящий запрос у себя и исходящий запроса у будущего друга
        inputRequestsCollection.document(userID).delete()
        outputFriendRequestsCollection.document(currentUserID).delete()
        
        //добавляем в список друзей
        addToFriend(userID: userID) { result in
            switch result {
                
            case .success(let mFriendUser):
                complition?(.success(mFriendUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///Отклоняем запрос от друга 
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let inputRequestsCollection = FirestoreEndPoint.inputRequests(userID: currentUserID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        guard let outputFriendRequestsCollection = FirestoreEndPoint.outputRequests(userID: userID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        //удаляем входящий запрос у себя и исходящий запроса у будущего друга
        inputRequestsCollection.document(userID).delete()
        outputFriendRequestsCollection.document(currentUserID).delete()
        
        getUser(id: userID) {[weak self] result in
            switch result {
                
            case .success(let mUser):
                let mRequestUser = MRequestUser(user: mUser)
                complition?(.success(mRequestUser))
                self?.sendNotificationToFriend(userToken: mUser.fcmKey, text: "Пользователь \(mUser.name ?? "") отклонил запрос")
            case .failure(_):
                complition?(.failure(FirestoreError.unownedError))
            }
        }
    }
    
    ///Отклоняем запрос от друга
    func rejectOutputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        //коллекция входящих у друга
        guard let inputFriendRequestsCollection = FirestoreEndPoint.inputRequests(userID: userID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        //коллекция исходящих у себя
        guard let outputRequestsCollection = FirestoreEndPoint.outputRequests(userID: currentUserID).collectionRef else {
            complition?(.failure(FirestoreError.collectionPathIncorrect))
            return
        }
        //удаляем входящий запрос у себя и исходящий запроса у будущего друга
        inputFriendRequestsCollection.document(currentUserID).delete()
        outputRequestsCollection.document(userID).delete()
        
        getUser(id: userID) {[weak self] result in
            switch result {
                
            case .success(let mUser):
                self?.sendNotificationToFriend(userToken: mUser.fcmKey, text: "Пользователь \(mUser.name ?? "") отозвал заявку на дружбу")
                complition?(.success(mUser))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///Добавление друга в коллекцию друзей, только после принятия входящего запроса.
    ///
    ///В остальных случаях необходимо отправлять исходящую заявку sendAddFriendRequst
    private func addToFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let currentUserFriendsCollection = FirestoreEndPoint.friends(userID: currentUserID).collectionRef,
              let friendFriendsCollection = FirestoreEndPoint.friends(userID: userID).collectionRef else {
                  complition?(.failure(FirestoreError.collectionPathIncorrect))
                  return
              }
        
        getUser(id: userID) {[weak self] result in
            switch result {
                
            case .success(let mUser):
                self?.getCurrentUser(complition: { resultCurrentUser in
                    switch resultCurrentUser {
                        
                    case .success(let mCurrentUser):
                        do {
                            //добавляем юзера к себе в коллекцию друзей
                            try currentUserFriendsCollection.document(mUser.userID).setData(from: mUser)
                            //добавляем себя в коллекцию друзей к другу
                            try friendFriendsCollection.document(mCurrentUser.userID).setData(from: mCurrentUser)
                            self?.sendNotificationToFriend(userToken: mUser.fcmKey, text: "У тебя новый друг")
                            complition?(.success(mUser))
                        } catch {
                            complition?(.failure(error))
                        }
                        
                    case .failure(let error):
                        complition?(.failure(error))
                    }
                })
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
    
    ///Удаление друга из коллекци друзей
     func removeFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        guard let currentUserFriendsCollection = FirestoreEndPoint.friends(userID: currentUserID).collectionRef,
              let friendFriendsCollection = FirestoreEndPoint.friends(userID: userID).collectionRef else {
                  complition?(.failure(FirestoreError.collectionPathIncorrect))
                  return
              }
         currentUserFriendsCollection.document(userID).delete()
         friendFriendsCollection.document(currentUserID).delete()
        
         getUser(id: userID) {[weak self] result in
             switch result {
                 
             case .success(let mUser):
                 self?.sendNotificationToFriend(userToken: mUser.fcmKey, text: "Пользователь \(mUser.name ?? "") удалил тебя из друзей")
                 complition?(.success(mUser))
             case .failure(let error):
                 complition?(.failure(error))
             }
         }
    }
    
    ///обновляем дату старта у друзей, в их списке друзей
    func updateStartDateInFriends(friendsIDs: [String], startDay: Double, complition: @escaping(Result<Bool, Error>) -> Void) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition(.failure(AuthError.userEmailNil))
            return
        }
        
        let batch = firestore.batch()
        friendsIDs.forEach { friendID in
            if let userInFriendRef = FirestoreEndPoint.friends(userID: friendID).collectionRef?.document(currentUserID) {
                batch.setData([MUser.CodingKeys.startDate.rawValue : startDay],
                              forDocument: userInFriendRef,
                              merge: true)
            }
        }
        
        batch.commit { error in
            if let error = error {
                complition(.failure(error))
            } else {
                complition(.success(true))
            }
        }
    }
    
    ///обновляем fcm ключ у друзей
    func updateFCMTokenInFriends(friendsIDs: [String], token: String, complition: @escaping(Result<Bool, Error>) -> Void) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition(.failure(AuthError.userError))
            return
        }
        guard let currentUserID = currentUser.email else {
            complition(.failure(AuthError.userEmailNil))
            return
        }
        
        let batch = firestore.batch()
        friendsIDs.forEach { friendID in
            if let userInFriendRef = FirestoreEndPoint.friends(userID: friendID).collectionRef?.document(currentUserID) {
                batch.updateData([MUser.CodingKeys.fcmKey.rawValue : token],
                                 forDocument: userInFriendRef)
            }
        }
        
        batch.commit { error in
            if let error = error {
                complition(.failure(error))
            } else {
                complition(.success(true))
            }
        }
    }
    
    func sendNotificationToFriend(userToken: String?, text: String) {
        //тут нужно отправлять пуш другу с текстом
        
    }
}
