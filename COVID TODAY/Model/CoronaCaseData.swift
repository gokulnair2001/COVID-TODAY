//
//  CoronaCaseModel.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import Foundation

//MARK:- JSON Data Model

struct coronaData:Decodable {
    let Global: global
    let Date: String
}
struct global:Decodable {
    let TotalDeaths:Double
    let NewConfirmed:Double
    let TotalConfirmed:Double
    let NewDeaths:Double
    let NewRecovered:Double
    let TotalRecovered:Double
}
