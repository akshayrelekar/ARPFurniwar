//
//  CartItem+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/13/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var quantity: Int16
    @NSManaged public var subTotal: Double
    @NSManaged public var associatedcart: Cart?
    @NSManaged public var products: Product?

}
