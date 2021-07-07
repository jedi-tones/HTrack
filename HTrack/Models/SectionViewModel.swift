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
    var header: CellViewModel?
    var footer: CellViewModel?
    var items: [CellViewModel]
}
