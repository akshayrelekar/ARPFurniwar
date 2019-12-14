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
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
    
    func updateTotal(cell: CartItemCell, quantity: Int){
         
              guard let indexPath = tableView.indexPath(for: cell) else { return }
                     for c in usercart!.item {
                         cartarr.append(c)
                     }

                 let cartItem = cartarr[indexPath.row]
                     //Update cart item quantity
                     cartItem.quantity = Int16(quantity)
                     print("quannn",quantity)
                       print("totsl",usercart!.total)
              //Update displayed cart total
             
              let total = usercart!.total - ( cartItem.subTotal * Double(cartItem.quantity))
              totalLabel.text = String(describing: total)
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CartItemCell
        cell.delegate = self as CartItemDelegate
        cell.nameLabel.text = arrcartitems[indexPath.row].products!.productName
        cell.priceLabel.text = String(describing: (arrcartitems[indexPath.row]).products!.productCost)
        cell.productImage.image = UIImage(data: arrcartitems[indexPath.row].products!.productImage!) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
          let currentcell =  tableView.cellForRow(at: indexPath)
            
            print("----",Int(arrcartitems[indexPath.row].quantity))
           
            updateTotal(cell: currentcell as! CartItemCell, quantity: Int(arrcartitems[indexPath.row].quantity))
            for userc in usercart!.item{
                           if(userc.products?.productName == arrcartitems[indexPath.row].products?.productName ){
                               usercart?.item.remove(userc)
                           }
                       }
            PersistentService.persistentContainer.viewContext.delete(arrcartitems[indexPath.row])
            PersistentService.saveContext()
            
            
           // updateCartItem(cell: currentcell as! CartItemCell, quantity: Int(arrcartitems[indexPath.row].quantity))
          
            
             arrcartitems.remove(at: indexPath.row)
                        //            ImageArray.remove(at: indexPath.row)
                                   
                                    tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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


