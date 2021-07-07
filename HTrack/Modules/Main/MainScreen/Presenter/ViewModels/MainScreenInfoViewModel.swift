//
//  MainScreenInfoViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import Foundation

protocol InfoViewModelDelegate {
    func didTapInfo()
}

class MainScreenInfoViewModel: CellViewModel {
    
    var delegate: InfoViewModelDelegate?
    var cell: BaseCell.Type {
        MainScreenInfoCell.self
    }
    
    var title: String?
    var description: String?
}

extension MainScreenInfoViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
    }
    
    static func == (lhs: MainScreenInfoViewModel, rhs: MainScreenInfoViewModel) -> Bool {
        lhs.title == rhs.title && lhs.description == rhs.description
    }
}
