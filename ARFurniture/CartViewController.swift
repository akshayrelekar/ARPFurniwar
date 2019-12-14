//
//  CartViewController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/10/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
   @IBOutlet weak var cartStateLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var c:Cart?
    var usercart: Cart?
    var arrcarts:[Cart] = [Cart]()
    var arrcartitems:[CartItem] = [CartItem]()
    var cartarr:[CartItem] = [CartItem]()
    var quotes : [(key: String, value: Float)] = []

//    fileprivate let apiKey = Bundle.main.object(forInfoDictionaryKey: "CL_APIKey") as! String
     let reuseIdentifier = "CartItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest:NSFetchRequest<Cart> = Cart.fetchRequest()
        do{
            let e = try PersistentService.context.fetch(fetchRequest)
            arrcarts = e
            
        }catch{
            print("cannot fetch the saved event")
        }

        for crt in arrcarts{
            if(crt.loggeduserid == LoginController.selecteduserid){
                usercart = crt
                break
            }
        }
        guard let cc = usercart else {
            return}
        for c in cc.item{
                  arrcartitems.append(c)
              }
        
        totalLabel.text = String(describing:  usercart!.total)
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    

    
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       print("!!",arrcartitems.count)
        return arrcartitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CartItemCell
        cell.delegate = self as CartItemDelegate
        cell.nameLabel.text = arrcartitems[indexPath.row].products!.productName
        cell.priceLabel.text = String(describing: (arrcartitems[indexPath.row]).products!.productCost)
        cell.productImage.image = UIImage(data: arrcartitems[indexPath.row].products!.productImage!) 
        return cell
    }
}

extension CartViewController: CartItemDelegate {
    
   //  MARK: - CartItemDelegate
    func updateCartItem(cell: CartItemCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        for c in usercart!.item {
            cartarr.append(c)
        }
        
    let cartItem = cartarr[indexPath.row]
        //Update cart item quantity
        cartItem.quantity = Int16(quantity)
        print("quan",quantity)
        //Update displayed cart total
        let total = usercart!.total + ( cartarr[indexPath.row].subTotal * Double(cartItem.quantity)) - cartarr[indexPath.row].subTotal
        totalLabel.text = String(describing: total)
    }
    
}


