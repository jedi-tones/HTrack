//
//  DayCountWidgetViewModel.swift
//  HTrack
//
//  Created by Jedi Tones on 12.11.2021.
//

import Foundation
import Combine

class DayCountWidgetViewModel: ObservableObject {
    @Published var widgetUser: WidgetUserModel
    
    var dateCount: Int {
        let startDate = widgetUser.startDate ?? Date()
        return getDayCountFrom(startDate)
    }
    
    var descString: String {
        let daysString = LocDic.daysWithoutAlcohol.withArguments([String(describing: dateCount)])
        return daysString.replacingOccurrences(of: " ", with: "\n")
    }
    private func getDayCountFrom(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        let day = components.day ?? 0
        return day
    }
    
    init(widgetUser: WidgetUserModel) {
        self.widgetUser = widgetUser
    }
}
