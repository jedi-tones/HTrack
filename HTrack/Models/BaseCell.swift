//
//  BaseCell.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import Foundation

protocol BaseCell: AnyObject {
    static var reuseID: String { get }
    func configure(viewModel: CellViewModel?)
}
