//
//  CoronaCaseModel.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import Foundation

struct caseModel {
    let tDeaths: Int
    let nDeaths:Int
    let tRecovery:Int
    let nRecovery: Int
    let tCase:Int
    let nCase:Int
    let time:String
    
    var conditionName: String {
        
        switch  tDeaths {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }

    }
}
