//
//  DataProvider.swift
//  COVIDTodayWidgetExtension
//
//  Created by Gokul Nair on 10/02/21.
//

import WidgetKit

struct Provider: IntentTimelineProvider {
   
    let loader = MainViewController()
   
    typealias Entry = COVIDEntry
    
    func placeholder(in context: Context) -> COVIDEntry {
        COVIDEntry.mockEntry()
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (COVIDEntry) -> ()) {
        let entry = COVIDEntry.mockEntry()
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        loader.get()
        if (loader.dataFetched == true){
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entry = COVIDEntry.mockEntry()
        let entryDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(entryDate))
        completion(timeline)
    }
  }
}
