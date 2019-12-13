//
//  CartViewController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/10/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
   
    
   @IBOutlet weak var cartStateLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var c:Cart?
    var usercart: Cart?
    var arrcartitems:[CartItem] = [CartItem]()
    var quotes : [(key: String, value: Float)] = []
//
    
//    fileprivate let apiKey = Bundle.main.object(forInfoDictionaryKey: "CL_APIKey") as! String
     let reuseIdentifier = "CartItemCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usercart = c
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        //Show the acitvity indicator
//        showActivityIndicator()
//
//        //Fill PickerView components
//        //Get asynchronisly component on a background thread
//        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
//            self.currencyHelper.refresh() { result in
//                //Update picker on main thread
//                DispatchQueue.main.async(execute: {
//                    //reload the picket view with the new quotes
//                    self.quotes = self.currencyHelper.all()
//                    self.currencyPickerView.reloadAllComponents()
//
//                    //Update Cart Total lale
//                    self.totalLabel.text = (self.cart?.total.description)! + " " + self.currencyHelper.selectedCurrency
//
//                    self.hideActivityIndicator()
//                })
//            }
//        })
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        //Hide the view components
        tableView.alpha = 0
        totalView.alpha = 0
        cartStateLabel.alpha = 0
        
        //Start the indicator
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        //Animate the cart view display
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            
            //show the view components
            self.tableView.alpha = 1
            self.totalView.alpha = 1
            self.cartStateLabel.alpha = self.usercart?.item?.count == 0 ? 1 : 0
            
            //Stop the activity indicator
            self.activityIndicatorView.stopAnimating()
        }, completion: nil)
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
        return 1
//        return (cart?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CartItemCell
        
        
        let arrayofcartitems = usercart?.item as! Set<CartItem>
        for setitems in arrayofcartitems{
          
            
            arrcartitems.append(setitems)
            print("$$$\(setitems.products?.productName)")
        }
        cell.delegate = self as? CartItemDelegate

       
        cell.nameLabel.text = arrcartitems[indexPath.row].products!.productName
        cell.priceLabel.text = String(describing: (arrcartitems[indexPath.row] as AnyObject).products?.productCost)
//        cell.quantityLabel.text = String(describing: usercart?.cartitem![indexPath.item] .quantity)
//            cell.quantity = cartarr![indexPath.item] .quantity
////
        
        return cell
    }
}



//extension CartViewController: CartItemDelegate {
    
    // MARK: - CartItemDelegate
//    func updateCartItem(cell: CartItemCell, quantity: Int) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//       let cartarr = cart?.cartitem?.allObjects
//
//        guard let cartItem = cartarr![indexPath.row] else { return }
//
//        //Update cart item quantity
//        cartItem.quantity = quantity
//
//        //Update displayed cart total
//        guard let total = cartarr![indexPath.row].subTotal else { return }
//        totalLabel.text = total
//    }
    
//}
