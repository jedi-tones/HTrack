//
//  FirebaseAuth.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit

protocol AppleAuthServiceProtocol {
    func AppleIDRequest(complition: @escaping (Result<(ASAuthorization, String), Error>) -> Void)
}

final class AppleAuthService: NSObject, AppleAuthServiceProtocol {
    static let shared = AppleAuthService()
    private override init() { }
    
    private let auth = Auth.auth()
    private var currentNonce: String?  //hashed nonce string
    private var complitionAuth: ((Result<(ASAuthorization, String), Error>) -> Void)?
    
    func AppleIDRequest(complition: @escaping (Result<(ASAuthorization, String), Error>) -> Void) {
        let request = createAplleIDRequest()
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        authController.delegate = self
        authController.presentationContextProvider = self
        
        authController.performRequests()
        
        complitionAuth = complition
    }
    
    
    //MARK: - createAplleIDRequest
    private func createAplleIDRequest() ->ASAuthorizationAppleIDRequest {
        
        let appleIDAuthProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDAuthProvider.createRequest()
        request.requestedScopes = [.fullName, .email ]
        
        let nonce = CryptoService.shared.randomNonceString()
        request.nonce = CryptoService.shared.sha256(nonce)
        currentNonce = nonce
        
        return request
    }
}

//MARK:  ASWebAuthenticationPresentationContextProviding
extension AppleAuthService: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let keyWindow: UIWindow = {
            return UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        }() else { fatalError("Can't get keyWindow")}
        return keyWindow
    }
}

extension AppleAuthService: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let complition = complitionAuth,
              let nonce = currentNonce
        else {
            complitionAuth?(.failure(AuthError.appleIDSignInError))
            return
        }
        complition(.success((authorization, nonce)))
    }
}
