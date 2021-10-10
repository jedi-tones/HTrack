//
//  FriendsManager+Listners.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import Foundation

protocol FriendsListnerDelegate: AnyObject {
    func friendAdd(friend: MUser)
    func frindsModified(friend: MUser)
    func friendRemoved(friend: MUser)
    
    func friendsSubscribeError(error: FirebaseListnersError)
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
    }
    
    func subscribeInputRequestsListner() throws {
        guard let userID = firUser?.email
        else { throw AuthError.authUserNil }
        
        friendsRequestManager.subscribeInputRequestsListner(forUserID: userID, delegate: self)
    }
    
    func subscribeOutputRequestsListner() throws {
        guard let userID = firUser?.email
        else { throw AuthError.authUserNil }
        
        friendsRequestManager.subscribeInputRequestsListner(forUserID: userID, delegate: self)
    }
}

extension FriendsManager: FriendsListnerDelegate {
    func friendAdd(friend: MUser) {
        guard !friends.contains(friend) else { return }
        
        friends.append(friend)
        updateFriends(friends)
    }
    
    func frindsModified(friend: MUser) {
        guard let index = friends.firstIndex(of: friend) else { return }
        
        friends[index] = friend
        updateFriends(friends)
    }
    
    func friendRemoved(friend: MUser) {
        guard let index = friends.firstIndex(of: friend) else { return }
        
        friends.remove(at: index)
        updateFriends(friends)
    }
    
    func friendsSubscribeError(error: FirebaseListnersError) {
        Logger.show(title: "Module error",
                    text: "\(type(of: self)) - \(#function) \(error)",
                    withHeader: true,
                    withFooter: true)
        
    }
}

extension FriendsManager: InputRequestListnerDelegate {
    func inputRequestAdd(request: MRequestUser) {
        guard !inputRequests.contains(request) else { return }
        
        inputRequests.append(request)
        updateInputRequsts(inputRequests)
    }
    
    func inputRequestModified(request: MRequestUser) {
        guard let index = inputRequests.firstIndex(of: request) else { return }
        
        inputRequests[index] = request
        updateInputRequsts(inputRequests)
    }
    
    func inputRequestRemoved(request: MRequestUser) {
        guard let index = inputRequests.firstIndex(of: request) else { return }
        
        inputRequests.remove(at: index)
        updateInputRequsts(inputRequests)
    }
    
    func inputRequestsSubscribeError(error: FirebaseListnersError) {
        Logger.show(title: "Module error",
                    text: "\(type(of: self)) - \(#function) \(error)",
                    withHeader: true,
                    withFooter: true)
        
    }
}
