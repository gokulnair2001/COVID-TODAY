//
//  ctSmallWidget.swift
//  COVIDTodayWidgetExtension
//
//  Created by Gokul Nair on 10/02/21.
//

import SwiftUI
import WidgetKit

let fetchedData = MainViewController()

struct ctSmallWidget: View {
    
    private var covidToday: coronaData
    
    init(_covidToday: coronaData) {
        self.covidToday = _covidToday
    }
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                Color.widgetBg
                Color.orange
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Rectangle().foregroundColor(.white).frame(width: 150, height: 150, alignment: .center).cornerRadius(15)
            }
            VStack(){
                Divider()
                Text("World Wide Stats").font(.system(size: 15)).bold().position(x: 80,y: 20).foregroundColor(.orange)
                Spacer()
            }
            HStack{
                VStack(alignment: .leading, spacing: 15){
                    Text("Recovered").fontWeight(.bold).font(.system(size: 12))
                    Text("Confired").fontWeight(.bold).font(.system(size: 12))
                    Text("Deaths").fontWeight(.bold).font(.system(size: 12))
                }
                VStack(alignment: .leading, spacing: 15){
                    Text("\(covidToday.Global.TotalRecovered)").font(.system(size: 12))
                    Text("\(covidToday.Global.TotalConfirmed)").font(.system(size: 12))
                    Text("\(covidToday.Global.TotalDeaths)").font(.system(size: 12))
                }
            }.padding()
        }
    }
}

struct ctSmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        ctSmallWidget(_covidToday: coronaData.init(Global: global.init(TotalDeaths: fetchedData.fTotalDeaths[0], NewConfirmed: fetchedData.fNewConfirmed[0], TotalConfirmed: 0.0, NewDeaths: 0.0, NewRecovered: 0.0, TotalRecovered: 0.0), Date: "Date"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension Color{
    static let widgetBg = Color("WidgetBg")
}
