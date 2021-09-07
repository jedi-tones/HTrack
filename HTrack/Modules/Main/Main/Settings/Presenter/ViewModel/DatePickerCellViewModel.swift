//
//  DatePickerCellViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 9/7/21.
//

import Foundation

protocol DatePickerCellViewModelDelegate: AnyObject {
    func dateChanged(date: Date)
}

class DatePickerCellViewModel: CellViewModel, Hashable {
    var cell: BaseCellProtocol.Type {
        DatePickerCell.self
    }
    
    weak var delegate: DatePickerCellViewModelDelegate?
    var title = ""
    var startDate: Date?
    
    func dateChanged(date: Date) {
        delegate?.dateChanged(date: date)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startDate)
        hasher.combine(title)
    }
    
    static func == (lhs: DatePickerCellViewModel, rhs: DatePickerCellViewModel) -> Bool {
        lhs.startDate == rhs.startDate && lhs.title == rhs.title
    }
}
