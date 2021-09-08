//
//  UserRequestManager.swift
//  HTrack
//
//  Created by Jedi Tones on 8/26/21.
//

import Foundation

class UserRequestManager {
    static let shared = UserRequestManager()
    
    private init() {}
    
    let firestoreManager = FirestoreManager.shared
    
    func saveUser(user: MUser, complition: ((Result<MUser,Error>) -> Void)?) {
        firestoreManager.saveUser(user: user, complition: complition)
    }
    
    func getCurrentUser(complition: ((Result<MUser,Error>) -> Void)?) {
        firestoreManager.getCurrentUser(complition: complition)
    }
    
    func getUser(id: String, complition: ((Result<MUser, Error>) -> Void)?) {
        firestoreManager.getUser(id: id, complition: complition)
    }
    
    func checkNickNameIsExists(nickname: String, complition:((Result<Bool,Error>) -> Void)?) {
        firestoreManager.checkNickNameIsExists(nickname: nickname, complition: complition)
    }
    
    func saveNickName(nickname: String, userID: String, complition:((Result<String,Error>) -> Void)?) {
        firestoreManager.saveNickName(nickname: nickname, userID: userID, complition: complition)
    }
    
    func updateUser(userID: String, dic:[MUser.CodingKeys: Any], complition: ((Result<[String : Any], Error>) -> Void)?) {
        let dicToFirebase: [String: Any] = Dictionary(uniqueKeysWithValues: dic.map({($0.key.rawValue, $0.value)}))
        
        Logger.show(title: "updateUser dic", text: "\(dicToFirebase)", withHeader: true, withFooter: true)
        
        firestoreManager.updateUser(userID: userID,
                                    dic: dicToFirebase) { result in
            switch result {
            case .success(let updatedDic):
                complition?(.success(updatedDic))
            case .failure(let error):
                complition?(.failure(error))
            }
        }
    }
}
