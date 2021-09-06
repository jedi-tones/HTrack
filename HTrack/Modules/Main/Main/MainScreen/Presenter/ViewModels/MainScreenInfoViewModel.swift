//
//  MainScreenInfoViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import Foundation

protocol MainScreenInfoCellDelegate {
    func update(vm: MainScreenInfoViewModel)
}

protocol InfoViewModelDelegate {
    func didTapInfo()
}

class MainScreenInfoViewModel: CellViewModel {
    
    var delegate: InfoViewModelDelegate?
    var cellDelegate: MainScreenInfoCellDelegate?
    
    var cell: BaseCellProtocol.Type {
        MainScreenInfoCell.self
    }
    var needAnimationTap = false
    var title: String?
    var description: String?

}

extension MainScreenInfoViewModel: MainScreenUpdateDelegate {
    func update(info: MainScreenInfoViewModel) {
        
        self.title = info.title
        self.description = info.description
        cellDelegate?.update(vm: self)
    }
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
