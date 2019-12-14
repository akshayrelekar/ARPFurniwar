//
//  Product+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/13/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var categoryname: String?
    @NSManaged public var productCost: Double
    @NSManaged public var productDesc: String?
    @NSManaged public var productId: Int16
    @NSManaged public var productImage: Data?
    @NSManaged public var productImageName: String?
    @NSManaged public var productName: String?
    @NSManaged public var productSpec: String?
    

}
