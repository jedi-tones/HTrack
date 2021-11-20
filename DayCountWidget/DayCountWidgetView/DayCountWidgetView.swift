//
//  DayCountWidgetView.swift
//  HTrack
//
//  Created by Jedi Tones on 11.11.2021.
//

import SwiftUI
import WidgetKit

struct DayCountWidgetView: View {
    @EnvironmentObject var viewModel: DayCountWidgetViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color(viewModel.backColor)
            VStack(alignment: .leading, spacing: 0) {
                Text("\(viewModel.dateCount)")
                    .font(Font(Styles.Fonts.widgetSoyuz1 as CTFont))
                    .minimumScaleFactor(0.2)
                Text(viewModel.descString)
                    .font(Font(Styles.Fonts.widgetSoyuz2 as CTFont))
//                    .fixedSize(horizontal: false, vertical: false)
                    .minimumScaleFactor(0.2)
            }
            .foregroundColor(viewModel.titleColor)
            .padding(.all, 16)
        }
    }
}

struct DayCountWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let startDate = Calendar.current.date(byAdding: .day, value: -1123211, to: Date())
        DayCountWidgetView().environmentObject(DayCountWidgetViewModel(widgetUser:  WidgetUserModel(name: "GRADUS", startDate: startDate)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
