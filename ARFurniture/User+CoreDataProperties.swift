//
//  User+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/11/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var emailaddress: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var profimg: Data?
    @NSManaged public var userId: Int16

}
