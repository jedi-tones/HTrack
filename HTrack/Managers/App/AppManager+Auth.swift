//
//  AppManager+Auth.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation
import FirebaseAuth

extension AppManager {
    func checkAuth(complition: @escaping (FirebaseAuthManager.UserState) -> Void)  {
        firebaseAuthService.checkAuthState(complition: complition)
    }
    
    func authWithApple(complition: @escaping (Result<User,AuthError>) -> Void) {
        //send apple auth request
        appleAuthService.AppleIDRequest {[unowned self] result in
            switch result {
            
            case .success((let authorization, let nonce)):
                let credential = firebaseAuthService.initializeFirebaseCredential(authorization: authorization,
                                                                                  nonce: nonce)
                //signIN in firebase with cred from apple
                firebaseAuthService.signInWithApple(credential: credential, complition: { (result) in
                    switch result {
                    
                    case .success(let signInUser):
                        complition(.success(signInUser))
                        
                    case .failure(let authError):
                        complition(.failure(AuthError.unowned(error: authError.localizedDescription)))
                    }
                })
            case .failure(let authError):
                complition(.failure(AuthError.unowned(error: authError.localizedDescription)))
            }
        }
    }
    
    func authWithEmail(email: String, password: String, complition: @escaping (Result<User, Error>)-> Void) {
        firebaseAuthService.signIn(email: email, password: password, complition: complition)
    }
    
    func registerWithEmail(email: String, password: String, complition: @escaping (Result<User, Error>)-> Void) {
        firebaseAuthService.register(email: email, password: password, complition: complition)
    }
    
    func checkIsEmailAlreadyRegister(email: String, complition: @escaping(Result<Bool, Error>) -> Void) {
        firebaseAuthService.isEmailAlreadyRegister(email: email, complition: complition)
    }
    
    func logOut() throws {
        do {
            try firebaseAuthService.signOut()
        } catch {
            throw error
        }
    }
}

