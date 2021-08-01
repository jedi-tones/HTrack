//
//  BaseSectionViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 7/9/21.
//

import Foundation

struct BaseSectionViewModel {
    var section: String
    var header: CellViewModel?
    var footer: CellViewModel?
    var items: [CellViewModel]
}
