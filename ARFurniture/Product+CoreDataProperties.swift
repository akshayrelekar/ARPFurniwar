//
//  Product+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 11/30/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productCost: Double
    @NSManaged public var productDesc: String?
    @NSManaged public var productId: Int16
    @NSManaged public var productImage: Data?
    @NSManaged public var productName: String?
    @NSManaged public var productSpec: String?
    @NSManaged public var categoryname: String?
}
