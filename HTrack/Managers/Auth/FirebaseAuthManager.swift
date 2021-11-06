//
//  FirebaseAuthentification.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import FirebaseAuth
import AuthenticationServices
import Combine

protocol FirebaseAuthProtocol {
    func initializeFirebaseCredential(authorization: ASAuthorization, nonce: String?) -> OAuthCredential
    func signInWithApple(credential: OAuthCredential, complition:@escaping(Result<User, Error>)->Void)
    func signOut() throws
    func reAuthentificate(credential: AuthCredential?, email: String?, password: String?, complition: @escaping (Result<User,Error>) -> Void)
    func getCurrentUser() -> User?
    func updateUser(user: User, complition: @escaping(Result<Bool, Error>)->Void)
    func checkAuthState(complition: @escaping (FirebaseAuthManager.UserState) -> Void)
}

protocol FirebaseAuthListner {
    func logOut()
    func logIn(user: User)
}

final class FirebaseAuthManager: FirebaseAuthProtocol {
    static let shared = FirebaseAuthManager()
    private init() {}
    private let auth = Auth.auth()
    
    enum UserState {
        case authorized
        case notAuthorized
        case notAvalible
    }
    
    let notifier = Notifier<FirebaseAuthListner>()
    
    var userStatePublisher:AnyPublisher<UserState, Never> {
        _userStatePublisher.eraseToAnyPublisher()
    }
    var _userStatePublisher = PassthroughSubject<UserState, Never>()
    
    private func updateSignIn(user: User) {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function) user: \(String(describing: user.email))",
                    withHeader: true,
                    withFooter: true)
        _userStatePublisher.send(.authorized)
        notifier.forEach({$0.logIn(user: user)})
    }
    
    private func updateLogOut() {
        Logger.show(title: "Manager",
                    text: "\(type(of: self)) - \(#function)",
                    withHeader: true,
                    withFooter: true)
        
        _userStatePublisher.send(.notAuthorized)
        notifier.forEach({$0.logOut()})
    }
    
    //MARK: - Initialize a Firebase credential from AppleIDAuth
    func initializeFirebaseCredential(authorization: ASAuthorization, nonce: String?) -> OAuthCredential {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            fatalError("Current credentioal is't AppleIDCredential")
        }
        guard let nonce = nonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            fatalError("Unable to fetch identity token")
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            fatalError("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        }
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        
        
        return credential
    }
    
    func checkAuthState(complition: @escaping (UserState) -> Void) {
       let user = getCurrentUser()
        
        if let authUser = user {
            updateUser(user: authUser) {[weak self] result in
                switch result {
                
                case .success(_):
//                    self?.updateSignIn(user: authUser)
                    complition(.authorized)
                    
                case .failure(_):
                    self?.updateLogOut()
                    complition(.notAvalible)
                }
            }
        } else {
            return complition(.notAuthorized)
        }
    }
    
    //MARK: - register mail
    func register(email: String,
                  password: String,
                  complition: @escaping (Result<User, Error>) -> Void ) {
            
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            
            guard let result = result else {
                complition(.failure(error!))
                return
            }
            self?.updateSignIn(user: result.user)
            complition(.success(result.user))
        }
    }
    
    //MARK: - signIn mail
    func signIn(email: String,
                password: String,
                complition: @escaping (Result<User,Error>) -> Void) {
    
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            
            guard let result = result else {
                complition(.failure(error!))
                return
            }
            
            self?.updateSignIn(user: result.user)
            complition(.success(result.user))
            
        }
    }
    
    //MARK: - signInWithApple
    func signInWithApple(credential: OAuthCredential, complition:@escaping(Result<User, Error>)->Void) {
        
        Auth.auth().signIn(with: credential) {[weak self] (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                complition(.failure(error))
                return
            }
            // User is signed in to Firebase with Apple.
            guard let user = authResult?.user else {
                complition(.failure(AuthError.userError))
                return
            }
            
            self?.updateSignIn(user: user)
            complition(.success(user))
        }
    }
    
    
    
    //MARK: - isEmailAlreadyRegister
    func isEmailAlreadyRegister(email: String?, complition: @escaping(Result<Bool,Error>) -> Void) {
        guard let email = email else { return }
        
        auth.fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                complition(.failure(error))
            } else if methods != nil {
                complition(.success(true))
            } else {
                complition(.success(false))
            }
        }
    }
    
    func checkAuthMethods(email: String, complition: @escaping(Result<AuthType,Error>) -> Void) {
        auth.fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                complition(.failure(error))
            } else if let methods = methods {
                if methods.contains("apple.com") {
                    complition(.success(.apple))
                } else if methods.contains("password") {
                        complition(.success(.mail))
                } else {
                    complition(.failure(AuthError.authTypeUnowned(types: methods)))
                }
            } else {
                complition(.failure(AuthError.authTypeEpmty))
            }
        }
    }
    
    //MARK: - verifyEmail
    func verifyEmail(user: User, complition: @escaping(Result<Bool,Error>) -> Void) {
        
        user.sendEmailVerification { error in
            
            //need complite verification method
        }
    }
    
    //MARK: - signOut
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            
           // let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
           // keyWindow?.rootViewController = AuthViewController(currentPeopleDelegate: currentPeopleDelegate)
            updateLogOut()
        } catch {
            throw error
        }
    }
    
    //MARK: - reAuthentificate
    func reAuthentificate(credential: AuthCredential?,
                          email: String?,
                          password: String?,
                          complition: @escaping (Result<User,Error>) -> Void) {
        let user = Auth.auth().currentUser

        if let newCredential = credential {
            user?.reauthenticate(with: newCredential) {[weak self] arg, error   in
                if let error = error {
                    complition(.failure(error))
                } else {
                    if let user = arg?.user {
                        self?.updateSignIn(user: user)
                        complition(.success(user))
                    }
                }
            }
        } else {
            //if dont have credential, login with email to get them
            guard let email = email else { complition(.failure(AuthError.invalidEmail)); return }
            guard let password = password else { complition(.failure(AuthError.invalidPassword)); return }
            
            Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
                if let error = error {
                    complition(.failure(error))
                }
                if let result = result {
                    self?.updateSignIn(user: result.user)
                    complition(.success(result.user))
                }
            }
        }
    }
    
    //MARK: - deleteUser
    func deleteUser(complition: @escaping (Result<Bool,Error>)-> Void) {
        auth.currentUser?.delete(completion: {[weak self] error in
            if let error = error {
                complition(.failure(error))
            } else {
                self?.updateLogOut()
                complition(.success(true))
            }
        })
    }
    
    //MARK: - reload
    func getCurrentUser() -> User? {
        auth.currentUser
    }
    
    func updateUser(user: User, complition: @escaping (Result<Bool,Error>) -> Void) {
        user.reload { (error) in
            if let error = error {
                complition(.failure(error))
            } else {
                complition(.success(true))
            }
        }
    }
}
