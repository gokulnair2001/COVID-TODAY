//
//  COVIDCase.swift
//  COVIDTodayWidgetExtension
//
//  Created by Gokul Nair on 10/02/21.
//

import WidgetKit


struct COVIDEntry: TimelineEntry {
    let date: Date
   // let configuration: ConfigurationIntent
    let cases: [coronaData]
    
    static func mockEntry() -> COVIDEntry{
        return COVIDEntry(date: Date(), cases: [coronaData(Global: global.init(TotalDeaths: 0.0, NewConfirmed: 0.0, TotalConfirmed: 0.0, NewDeaths: 0.0, NewRecovered: 0.0, TotalRecovered: 0.0), Date: "Date" )])
    }
}
