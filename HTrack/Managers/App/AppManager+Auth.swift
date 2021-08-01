//
//  AppManager+Auth.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation
import FirebaseAuth

extension AppManager {
    func checkAuth(complition: @escaping (FirebaseAuthentificationService.UserState) -> Void)  {
        firebaseAuthService.checkAuthState(complition: complition)
    }
    
    func authWithApple(complition: @escaping (Result<User,AuthError>) -> Void) {
        appleAuthService.AppleIDRequest {[unowned self] result in
            switch result {
            
            case .success((let authorization, let nonce)):
                let credential = firebaseAuthService.initializeFirebaseCredential(authorization: authorization,
                                                                                  nonce: nonce)
                //signIN
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
}

