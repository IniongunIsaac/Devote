//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Isaac Iniongun on 29/03/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    private var isNotSmallFamily: Bool {
        widgetFamily != .systemSmall
    }
    private var fontStyle: Font {
        .system(isNotSmallFamily ? .headline : .footnote, design: .rounded)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(
                        width: isNotSmallFamily ? 56 : 36,
                        height: isNotSmallFamily ? 56 : 36
                    )
                    .offset(
                        x: (geometry.size.width / 2) - 20,
                        y: (geometry.size.height / -2) + 20
                    )
                    .padding(.top, isNotSmallFamily ? 32 : 12)
                    .padding(.trailing, isNotSmallFamily ? 32 : 12)
                
                HStack {
                    Text("Just Do It")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(.black.opacity(0.5).blendMode(.overlay))
                    .clipShape(Capsule())
                    
                    Spacer()
                } //: HStack
                .padding()
                .offset(y: (geometry.size.height / 2) - 24)
            } //: ZStack
        } //: GeometryReader
    }
}

struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widget for the personal task manager app.")
    }
}

struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
