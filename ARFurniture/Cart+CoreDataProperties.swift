//
//  Cart+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/13/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var cartid: Int16
    @NSManaged public var loggeduserid: Int16
    @NSManaged public var total: Double
    @NSManaged public var item: Set<CartItem>?

}

// MARK: Generated accessors for item
//extension Cart {
//
//    @objc(addItemObject:)
//    @NSManaged public func addToItem(_ value: CartItem)
//
//    @objc(removeItemObject:)
//    @NSManaged public func removeFromItem(_ value: CartItem)
//
//    @objc(addItem:)
//    @NSManaged public func addToItem(_ values: NSSet)
//
//    @objc(removeItem:)
//    @NSManaged public func removeFromItem(_ values: NSSet)
//
//}
