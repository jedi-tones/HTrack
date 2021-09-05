//
//  BaseCell.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import UIKit

protocol BaseCellProtocol: AnyObject {
    static var reuseID: String { get }
    var needAnimationTap: Bool { get set }
    func configure(viewModel: CellViewModel?)
    func tapAction()
}

extension BaseCellProtocol {
    func tapAction() {
        
    }
}
