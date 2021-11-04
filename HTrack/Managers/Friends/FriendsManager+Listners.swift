//
//  FriendsManager+Listners.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation
import Combine

protocol FriendsListnerDelegate: AnyObject {
    var friendsListnerPublisher: CurrentValueSubject<[MUser], Never> { get }
        
    func _friendAdd(friend: MUser)
    func _frindsModified(friend: MUser)
    func _friendRemoved(friend: MUser)
    
    func _friendsSubscribeError(error: FirebaseListnersError)
}

protocol InputRequestListnerDelegate: AnyObject {
    func inputRequestAdd(request: MRequestUser)
    func inputRequestModified(request: MRequestUser)
    func inputRequestRemoved(request: MRequestUser)
    
    func inputRequestsSubscribeError(error: FirebaseListnersError)
}

protocol OutputRequestListnerDelegate: AnyObject {
    func outputRequestAdd(request: MRequestUser)
    func outputRequestModified(request: MRequestUser)
    func outputRequestRemoved(request: MRequestUser)
    
    func outputRequestsSubscribeError(error: FirebaseListnersError)
}

extension FriendsManager {
    func subscribeFriendsListner() throws  {
        guard let userID = firUser?.email
        else { throw AuthError.authUserNil }
        
        friendsRequestManager.subscribeFriendsListner(forUserID: userID, delegate: self)
        friendsListnerPublisher
            .sink {[weak self] updatedFriends in
                self?.friendsP = updatedFriends
            }
            .store(in: &cancellable)
    }
    
    func subscribeInputRequestsListner() throws {
        guard let userID = firUser?.email
        else { throw AuthError.authUserNil }
        
        friendsRequestManager.subscribeInputRequestsListner(forUserID: userID, delegate: self)
    }
    
    func subscribeOutputRequestsListner() throws {
        guard let userID = firUser?.email
        else { throw AuthError.authUserNil }
        
        friendsRequestManager.subscribeOutputRequestsListner(forUserID: userID, delegate: self)
    }
    
    func unsubscribeOutputRequestsListner() {
        friendsRequestManager.unsubscribeOutputRequestsListner()
    }
}

extension FriendsManager: FriendsListnerDelegate {
    func _friendAdd(friend: MUser) {
        guard !friendsP.contains(where: {$0.userID == friend.userID}) else { return }
        
//        friendsP.append(friend)
    }
    
    func _frindsModified(friend: MUser) {
        guard let index = friendsP.firstIndex(where: {$0.userID == friend.userID}) else { return }
        
//        friendsP[index] = friend
    }
    
    func _friendRemoved(friend: MUser) {
        guard let index = friendsP.firstIndex(where: {$0.userID == friend.userID}) else { return }
        
//        friendsP.remove(at: index)
    }
    
    func _friendsSubscribeError(error: FirebaseListnersError) {
        Logger.show(title: "Module error",
                    text: "\(type(of: self)) - \(#function) \(error)",
                    withHeader: true,
                    withFooter: true)
        
    }
}

extension FriendsManager: InputRequestListnerDelegate {
    func inputRequestAdd(request: MRequestUser) {
        guard !inputRequestsP.contains(where: {$0.userID == request.userID}) else { return }
        
        inputRequestsP.append(request)
    }
    
    func inputRequestModified(request: MRequestUser) {
        guard let index = inputRequestsP.firstIndex(where: {$0.userID == request.userID}) else { return }
        
        inputRequestsP[index] = request
    }
    
    func inputRequestRemoved(request: MRequestUser) {
        guard let index = inputRequestsP.firstIndex(where: {$0.userID == request.userID}) else { return }
        
        inputRequestsP.remove(at: index)
    }
    
    func inputRequestsSubscribeError(error: FirebaseListnersError) {
        Logger.show(title: "Module error",
                    text: "\(type(of: self)) - \(#function) \(error)",
                    withHeader: true,
                    withFooter: true)
        
    }
}

extension FriendsManager: OutputRequestListnerDelegate {
    func outputRequestAdd(request: MRequestUser) {
        guard !outputRequests.contains(where: {$0.userID == request.userID}) else { return }
        
        outputRequests.append(request)
        updateOutputRequsts(outputRequests)
    }
    
    func outputRequestModified(request: MRequestUser) {
        guard let index = outputRequests.firstIndex(where: {$0.userID == request.userID}) else { return }
        
        outputRequests[index] = request
        updateOutputRequsts(outputRequests)
    }
    
    func outputRequestRemoved(request: MRequestUser) {
        guard let index = outputRequests.firstIndex(where: {$0.userID == request.userID}) else { return }
        
        outputRequests.remove(at: index)
        updateOutputRequsts(outputRequests)
    }
    
    func outputRequestsSubscribeError(error: FirebaseListnersError) {
        Logger.show(title: "Module error",
                    text: "\(type(of: self)) - \(#function) \(error)",
                    withHeader: true,
                    withFooter: true)
    }
}
