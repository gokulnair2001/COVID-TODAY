//
//  User+CoreDataProperties.swift
//  COVID TODAY
//
//  Created by Gokul Nair on 30/09/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var pincode: String?

}

extension User : Identifiable {

}
