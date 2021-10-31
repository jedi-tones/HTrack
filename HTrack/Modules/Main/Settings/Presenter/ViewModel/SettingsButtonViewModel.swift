//
//  SettingsButtonViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/6/21.
//

import Foundation

protocol SettingsButtonViewModelDelegate: AnyObject {
    func didTap(element: SettingsElement?)
}

class SettingsButtonViewModel: CellViewModel, Hashable {
    var cell: BaseCellProtocol.Type {
        SettingsButtonCell.self
    }
    
    var needAnimationTap = true
    var sensetive = false
    weak var delegate: SettingsButtonViewModelDelegate?
    var element: SettingsElement?
    var title: String?
    
     func didTap() {
        delegate?.didTap(element: self.element)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(element)
    }
    
    static func == (lhs: SettingsButtonViewModel, rhs: SettingsButtonViewModel) -> Bool {
        lhs.title == rhs.title && lhs.element == rhs.element
    }
}

