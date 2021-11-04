//
//  FriendsManager.swift
//  HTrack
//
//  Created by Jedi Tones on 9/12/21.
//

import FirebaseAuth
import Combine

protocol FriendsManagerOutputRequestsListner {
    func outputRequestsUpdated(request: [MRequestUser])
}

protocol FriendsManagerProtocol {
    var friendsP: [MUser] { get }
    var inputRequestsP: [MRequestUser] { get }
    var outputRequestsP: [MRequestUser] { get }
    
    var friendsPublisher: Published<[MUser]>.Publisher { get }
    var inputRequestsPublisher: Published<[MRequestUser]>.Publisher { get }
    var outputRequestsRequestsPublisher: Published<[MRequestUser]>.Publisher { get }
    
    func checkCanAddFriendRequest(userName: String, complition:((Result<MUser,Error>) -> Void)?)
    func sendAddFriendRequst(currentMUser: MUser, toUser: MUser?, userID: String, complition:((Result<MRequestUser,Error>) -> Void)?)
    func acceptInputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?)
    func rejectInputRequest(userID: String, complition:((Result<MRequestUser,Error>) -> Void)?)
    func rejectOutputRequest(userID: String, complition:((Result<MUser,Error>) -> Void)?)
    func removeFriend(userID: String, complition:((Result<MUser,Error>) -> Void)?)
    func updateStartDateInFriends(startDay: Double, complition: @escaping(Result<Bool, Error>) -> Void)
}

class FriendsManager: FriendsManagerProtocol {
    static let shared = FriendsManager()
    
    private init() {
        subscribeListners()
        firebaseAuthService.notifier.subscribe(self)
    }
    
    deinit {
        friendsRequestManager.unsubscribeFriendsListner()
        friendsRequestManager.unsubscribeInputRequestsListner()
        firebaseAuthService.notifier.unsubscribe(self)
    }
    
    let firebaseAuthService = FirebaseAuthManager.shared
    let friendsRequestManager = FriendsRequestManager.shared
    let outputRequestsNotifier = Notifier<FriendsManagerOutputRequestsListner>()
    
    var firUser: User? { firebaseAuthService.getCurrentUser() }
    var cancellable: Set<AnyCancellable> = []
    
    @Published var friendsP: [MUser] = []
    @Published var inputRequestsP: [MRequestUser] = []
    @Published var outputRequestsP: [MRequestUser] = []
    
    var friendsPublisher: Published<[MUser]>.Publisher { $friendsP }
    var inputRequestsPublisher: Published<[MRequestUser]>.Publisher { $inputRequestsP }
    var outputRequestsRequestsPublisher: Published<[MRequestUser]>.Publisher { $outputRequestsP }
    
    var friendsFirebaseListnerPublisher = CurrentValueSubject<[MUser], Never>([])
    var inputRequestFirebaseListnerPublisher = CurrentValueSubject<[MRequestUser], Never>([])
    var outputRequestFirebaseListnerPublisher = CurrentValueSubject<[MRequestUser], Never>([])
    
    var serialOutputQ = DispatchQueue(label: "serialOutput")
    
    func subscribeListners() {
        do {
            try subscribeFriendsListner()
            try subscribeInputRequestsListner()
        } catch {
            Logger.show(title: "subscribe Listners ERROR",
                        text: "\(String(describing: error.localizedDescription))",
                        withHeader: true,
                        withFooter: true)
        }
    }
}
