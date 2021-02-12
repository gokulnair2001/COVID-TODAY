//
//  COVIDTodayWidget.swift
//  COVIDTodayWidget
//
//  Created by Gokul Nair on 10/02/21.
//

import WidgetKit
import SwiftUI
import Intents

struct COVIDTodayWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ctSmallWidget(_covidToday: entry.cases.first!)
        case .systemMedium:
            ctMediumWidget(_covidToday: entry.cases.first!)
        default:
            fatalError()
        }
    }
}

@main
struct COVIDTodayWidget: Widget {
    let kind: String = "COVIDTodayWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            COVIDTodayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("COVID Case Statistics")
        .description("Shows World wide COVID case statistics")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct COVIDTodayWidget_Previews: PreviewProvider {
    static var previews: some View {
        COVIDTodayWidgetEntryView(entry: COVIDEntry.mockEntry())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
