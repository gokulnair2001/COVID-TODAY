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
        case 200000:
            return ""
        case 300000:
            return ""
        default:
            return ""
        }

    }
}
