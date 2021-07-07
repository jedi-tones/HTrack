//
//  CoordinatorProtocol.swift
//  HTrack
//
//  Created by Jedi Tones on 6/13/21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var modulePresenter: Presentable? { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    
    func start(animated: Bool)
    func childDidFinish(_ child: CoordinatorProtocol?)
    
    func addCoordinator(_ coordinator: CoordinatorProtocol)
    func removeCoordinator(_ coordinator: CoordinatorProtocol?)
}

extension CoordinatorProtocol {
    func addCoordinator(_ coordinator: CoordinatorProtocol) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        
        childCoordinators.append(coordinator)
    }
    
    func removeCoordinator(_ coordinator: CoordinatorProtocol?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
