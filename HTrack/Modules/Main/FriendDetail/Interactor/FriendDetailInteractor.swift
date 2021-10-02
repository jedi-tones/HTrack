//  Created by Denis Shchigolev on 02/10/2021.
//  Copyright © 2021 HTrack. All rights reserved.

class FriendDetailInteractor {
    weak var output: FriendDetailInteractorOutput!

    deinit {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
    }
    
    private var friend: MUser?
    
    var friendDayCount: Int {
        return friend?.startDate?.getDayCount() ?? 0
    }
    
    var friendName: String {
        return friend?.name ?? "Friend"
    }
}

// MARK: - FriendDetailInteractorInput
extension FriendDetailInteractor: FriendDetailInteractorInput {
    func getModuleElements() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        let elements = FriendsDetailElement.allCases
        output.setupModule(elements: elements)
    }
    
    func setFriend(friend: MUser) {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
        self.friend = friend
    }
    
    func removeFriend() {
        Logger.show(title: "Module",
                    text: "\(type(of: self)) - \(#function)")
        
    }
}
