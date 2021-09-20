//
//  SectionViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 6/20/21.
//

import Foundation
import UIKit

struct SectionViewModel {
    var section: String
    var id = UUID()
    var header: CellViewModel?
    var footer: CellViewModel?
    var items: [CellViewModel]
}

extension SectionViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(section)
        hasher.combine(id)
    }
    
    static func == (lhs: SectionViewModel, rhs: SectionViewModel) -> Bool {
        lhs.section == rhs.section &&
            lhs.header?.cell.reuseID == rhs.header?.cell.reuseID &&
            lhs.footer?.cell.reuseID == rhs.footer?.cell.reuseID
    }
}
 
