//
//  DayCountWidgetView.swift
//  HTrack
//
//  Created by Jedi Tones on 11.11.2021.
//

import SwiftUI
import WidgetKit

struct DayCountWidgetView: View {
    let widgetUser: WidgetUserModel
    var dateCount: Int {
        let startDate = widgetUser.startDate ?? Date()
        return getDayCountFrom(startDate)
    }
    
    func getDayCountFrom(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date, to: Date())
        let day = components.day ?? 0
        return day
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color(UIColor.black)
            VStack(alignment: .leading, spacing: 04) {
                Text("\(dateCount)")
                    .font(.system(size: 36, weight: .bold, design: .default))
                Text("дней \nбез \nалкоголя")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            .foregroundColor(.white)
//            .background(Color(UIColor.red))
            .padding(.all, 10)
        }
    }
}

struct DayCountWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        DayCountWidgetView(widgetUser: WidgetUserModel(name: "GRADUS", startDate: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
