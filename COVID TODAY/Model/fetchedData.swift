//
//  fetchedData.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 11/02/21.
//

import Foundation

struct fetchedData:Decodable {
    let Global: Global
    let Date: String
}
struct Global:Decodable {
    let TotalDeaths:Double 
    let NewConfirmed:Double
    let TotalConfirmed:Double
    let NewDeaths:Double
    let NewRecovered:Double
    let TotalRecovered:Double
}
