//
//  DatabaseHelper.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:[String:String]){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.name = object["name"]
        user.number = object["number"]
        user.address = object["address"]
        user.pincode = object["pincode"]
        do{
            try context?.save()
        }catch{
            print("error found")
        }
    }
}
