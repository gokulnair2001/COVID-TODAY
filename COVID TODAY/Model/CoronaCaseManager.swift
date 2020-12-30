//
//  CoronaCaseManager.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import Foundation
protocol CoronaCaseManagerDelegate {
    func didUpdateStats(_ caseManager: caseManager, stats: caseModel)
    func didFailWithError(error: Error)
}

struct caseManager {
    
    var delegate: CoronaCaseManagerDelegate?
    
    func performURL(){
     
        //MARK:- create url
        
        if let url = URL(string: "https://api.covid19api.com/summary"){
            
            //MARK:- create a url session
            
            let session = URLSession(configuration: .default)
            
            //MARK:- give session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let stat =  self.parseJSON(safeData){
                        self.delegate?.didUpdateStats(self, stats: stat)
                        print("okkk")
                    }
                }
                
            }
            //MARK:- start the task
            
            task.resume()
            
        }
    }
    
    //MARK:- Parsing the data
    
    func parseJSON(_ stats: Data)-> caseModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(coronaData.self, from: stats)
            let totalDeaths = decodedData.Global.TotalDeaths
            let totalCase = decodedData.Global.TotalConfirmed
            let totalRecovery = decodedData.Global.TotalRecovered
            let newDeaths = decodedData.Global.NewDeaths
            let newRecovery = decodedData.Global.NewRecovered
            let newCase = decodedData.Global.NewConfirmed
            let time = decodedData.Date
            print(totalDeaths)
            print(totalCase)
            print(totalRecovery)
            print(newDeaths)
            print(newRecovery)
            print(newCase)
            print(time)
            
            let caseStats = caseModel(tDeaths: Int(totalDeaths), nDeaths: Int(newDeaths), tRecovery: Int(totalRecovery), nRecovery: Int(newRecovery), tCase: Int(totalCase), nCase: Int(newCase), time: time)
            return caseStats
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
