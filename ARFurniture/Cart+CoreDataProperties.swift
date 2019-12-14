//
//  Cart+CoreDataProperties.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/13/19.
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
    @NSManaged public var item: Set<CartItem>

}

// MARK: Generated accessors for item
extension Cart {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: CartItem)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: CartItem)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

    
   
//    var total1: Double {
//        get { return item.reduce(0.0) { value, item in
//            value + item.subTotal
//            }
//        }
//    }
//
//    var totalQuantity : Int {
//        get { return item.reduce(0) { value, item in
//            value + Int(item.quantity)
//            }
//        }
//    }
//
//    func totalInCurrency(name: String, for total: Float) -> Float {
//           self.selectedCurrency = name
//           guard let rate = currency?.quotes["USD"+name] else { return total }
//           return total * rate
//       }
////
////       func display(total: Float) -> String {
////           let newTotal = totalInCurrency(name: selectedCurrency, for: total)
////           return String(format: "%.2f", newTotal) + " " + selectedCurrency
////       }
////
//////    func updateCart(with product: Product) {
//////        if !self.contains(product: product) {
//////            self.add(product: product)
//////        } else {
//////            self.remove(product: product)
//////        }
////    }
//
////    func add(product: Product) {
////           let item1 = item.filter { $0.products == product }
////
////           if item.first != nil {
////               item.first!.quantity += 1
////           } else {
////
////               item.insert(CartItem)
////           }
////       }
//
//    func updateCart() {
//
//        for item in self.item {
//            if item.quantity == 0 {
//                updateCart(with: item.products!)
//            }
//        }
//    }
//
//
//
//    func remove(product: Product) {
//        guard let index = item.index(where: { $0.products == product }) else { return}
//        item.remove(at: index)
//    }
//
//    func contains(product: Product) -> Bool {
//        let item1 = item.filter { $0.products == product }
//        return item.first != nil
//    }
}
