//
//  ctMediumWidget.swift
//  COVIDTodayWidgetExtension
//
//  Created by Gokul Nair on 10/02/21.
//

import SwiftUI
import WidgetKit

struct ctMediumWidget: View {
    
    private var covidToday: coronaData
    
    init(_covidToday: coronaData) {
        self.covidToday = _covidToday
    }
    var body: some View {
        ZStack{
            VStack{
                VStack(spacing: 0){
                    Color.orange
                    Color.widgetBg
                }
            }
            VStack{
                Rectangle().foregroundColor(.white).frame(width: 340, height: 150, alignment: .center).cornerRadius(15)
            }
            VStack(){
                Divider()
                Text("World Wide Cases").font(.system(size: 20)).bold().position(x: 110,y: 23).foregroundColor(.orange)
                Spacer()
            }
            HStack(alignment: .center){
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("Recovered").fontWeight(.bold).font(.system(size: 12))
                        Text("Confired").fontWeight(.bold).font(.system(size: 12))
                        Text("Deaths").fontWeight(.bold).font(.system(size: 12))
                    }.frame(width: 90)
                    
                    
                    VStack(spacing: 10){
                        Text("\(covidToday.Global.TotalRecovered)").font(.system(size: 10))
                        Text("\(covidToday.Global.TotalConfirmed)").font(.system(size: 10))
                        Text("\(covidToday.Global.TotalDeaths)").font(.system(size: 10))
                    }.frame(width: 50)
                }.padding()
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("T.Recovered").fontWeight(.bold).font(.system(size: 12))
                        Text("T.Confired").fontWeight(.bold).font(.system(size: 12))
                        Text("T.Deaths").fontWeight(.bold).font(.system(size: 12))
                    }.frame(width: 90)
                    
                    VStack(spacing: 10){
                        Text("\(covidToday.Global.TotalRecovered)").font(.system(size: 10))
                        Text("\(covidToday.Global.TotalConfirmed)").font(.system(size: 10))
                        Text("\(covidToday.Global.TotalDeaths)").font(.system(size: 10))
                    }.frame(width: 50)
                }.padding().frame(width: 190, height: 100, alignment: .leading)
            }.offset(y: 10)
        }
    }
}

struct ctMediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        ctMediumWidget(_covidToday: coronaData.init(Global: global.init(TotalDeaths: fetchedData.fTotalDeaths[0], NewConfirmed: fetchedData.fNewConfirmed[0], TotalConfirmed: 0.0, NewDeaths: 0.0, NewRecovered: 0.0, TotalRecovered: 0.0), Date: "Date"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
