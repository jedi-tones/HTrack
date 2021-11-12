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
            Color(UIColor.black)
            VStack(alignment: .leading, spacing: 04) {
                Text("\(viewModel.dateCount)")
                    .font(Font(Styles.Fonts.soyuz2 as CTFont))
                Text(viewModel.descString)
                    .font(Font(Styles.Fonts.soyuz1 as CTFont))
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
        DayCountWidgetView().environmentObject(DayCountWidgetViewModel(widgetUser:  WidgetUserModel(name: "GRADUS", startDate: Date())))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
