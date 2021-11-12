//
//  DayCountWidget.swift
//  DayCountWidget
//
//  Created by Jedi Tones on 11.11.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("currenWidgettUser", store: UserDefaults(suiteName: "group.flava.app.HTrack"))
    var currentUserData = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        let placeholderUser = WidgetUserModel(name: "GRADUS", startDate: Date())
        return SimpleEntry(date: Date(), currentWidgetUser: placeholderUser, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let widgetUser = try? JSONDecoder().decode(WidgetUserModel.self, from: currentUserData) else { return }
        let entry = SimpleEntry(date: Date(), currentWidgetUser: widgetUser, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        guard let widgetUser = try? JSONDecoder().decode(WidgetUserModel.self, from: currentUserData) else { return }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, currentWidgetUser: widgetUser, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let currentWidgetUser: WidgetUserModel
    let configuration: ConfigurationIntent
}

@main
struct DayCountWidget: Widget {
    let kind: String = "DayCountWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry  in
            return DayCountWidgetView().environmentObject(DayCountWidgetViewModel(widgetUser:entry.currentWidgetUser))
        }
        .configurationDisplayName("Gradus days count")
        .description("Days count widget")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}

struct DayCountWidget_Previews: PreviewProvider {
    static var previews: some View {
        let placeholderUser = WidgetUserModel(name: "GRADUS", startDate: Date())
        let vm = DayCountWidgetViewModel(widgetUser:placeholderUser)
        DayCountWidgetView().environmentObject(vm)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
