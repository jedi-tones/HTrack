//
//  FirestoreManeger+FriendsActions.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/10/21.
//

import Foundation
import FirebaseFirestoreSwift

extension FirestoreManager {
    func sendAddFriendRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        guard let currentUser = authFirestoreManager.getCurrentUser() else {
            complition?(.failure(AuthError.userError))
            return
        }
        
        guard let currentUserID = currentUser.email else {
            complition?(.failure(AuthError.userEmailNil))
            return
        }
        
        let currentUserFriendsCollection = FirestoreEndPoint.friends(userID: currentUserID).collectionRef
        let friendFriendsCollection = FirestoreEndPoint.friends(userID: userID).collectionRef
        
        let currentUserInputRequestCollection = FirestoreEndPoint.inputRequests(userID: currentUserID).collectionRef
        let friendInputRequestCollection = FirestoreEndPoint.inputRequests(userID: userID).collectionRef
        
        let currentUserOutputRequestCollection = FirestoreEndPoint.outputRequests(userID: currentUserID).collectionRef
        let friendOutputRequestCollection = FirestoreEndPoint.outputRequests(userID: userID).collectionRef
        

        
        
    }
    
    func checkUserIsAvalible(userName: String, complition:((Result<MRequestUser?,Error>) -> Void)?) {
        let waitOperation = BaseAsyncOperationConstructor { input, complition in
            print("operationTest: start wait")
            sleep(2)
            print("operationTest: after sleep 2")
            complition(.success(nil))
        }
        let checkUserOperation = BaseAsyncOperationConstructor {[weak self] input, complitionOperation in
            self?.getUser(nickname: userName) { result in
                switch result {

                case .success(let mUser):
                    print("operationTest: user check complite id:\(mUser.userID)")
                    complitionOperation(.success(mUser))
                case .failure(let error):
                    complitionOperation(.failure([error], nil))
                }
            }
        }

        let operationQueue = COperationQueue()
        operationQueue.qualityOfService = .background
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperations(operations: [waitOperation,checkUserOperation]) { resultOperation in
            if let resultOperation = resultOperation {
                switch resultOperation {

                case .success(let result):
                    if let mUser = result as? MUser {
                        let requestUser = MRequestUser(nickname: mUser.name,
                                                       userID: mUser.userID,
                                                       photo: mUser.photo)
                        complition?(.success(requestUser))
                    } else {
                        complition?(.failure(FirestoreError.userWithNameNotExist))
                    }
                case .failure(let error, _):
                    complition?(.failure(error.first ?? FirestoreError.getDocumentDataError))
                }
            } else {
                complition?(.success(nil))
            }
        }
        operationQueue.start()
//        getUser(nickname: userName) { result in
//            switch result {
//                
//            case .success(let mUser):
//                print("operationTest: user check complite id:\(mUser.userID)")
//                complition?(.success(nil))
//            case .failure(let error):
//                complition?(.failure(error))
//            }
//        }
    }
    
    func acceptInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
        
    }
    
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?) {
       
    }
}
