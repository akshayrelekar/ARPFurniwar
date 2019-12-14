//
//  CartViewController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/10/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData
import Braintree

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
   @IBOutlet weak var cartStateLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var braintreeclient: BTAPIClient?
    var c:Cart?
    var usercart: Cart?
    var arrcarts:[Cart] = [Cart]()
    var arrcartitems:[CartItem] = [CartItem]()
    var cartarr:[CartItem] = [CartItem]()
    var quotes : [(key: String, value: Float)] = []
    private var hud : MBProgressHUD!
    var grand : Double = 0.0
//    fileprivate let apiKey = Bundle.main.object(forInfoDictionaryKey: "CL_APIKey") as! String
     let reuseIdentifier = "CartItemCell"
    @IBOutlet var cartView: UIView!
    
    
    @IBAction func placeOrderPressed(_ sender: UIButton) {
        
        let payPalDriver = BTPayPalDriver(apiClient: braintreeclient!)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self
        print(grand)
        let request = BTPayPalRequest(amount: "\(grand)")
        request.currencyCode = "USD"
        payPalDriver.requestOneTimePayment(request){(tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount{
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                 let email = tokenizedPayPalAccount.email
                 print(email)
                 let firstName = tokenizedPayPalAccount.firstName
                 print(firstName)
                 let lastName = tokenizedPayPalAccount.lastName
                 let phone = tokenizedPayPalAccount.phone
                 let billingAddress = tokenizedPayPalAccount.billingAddress
                 let shippingAddress = tokenizedPayPalAccount.shippingAddress
             
             let alert = UIAlertController(title: "✅", message: "Payment Successful", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
              self.present(alert, animated: true, completion: nil)
             
            }else if let error = error{
                print("Error while payment: ",error)
             let alert = UIAlertController(title: "❌", message: "Payment Unsuccessful", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
              self.present(alert, animated: true, completion: nil)
            }else{
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeclient = BTAPIClient(authorization: "sandbox_d56x9zp3_2qc47655x8hvhfxh")
        self.hud = MBProgressHUD.showAdded(to: self.cartView, animated: true)
        self.hud.label.text = "Just a sec"
        self.hud.hide(animated: true, afterDelay: 1.5)
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
        grand = usercart!.total
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
//            ImageArray.remove(at: indexPath.row   )
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
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

extension CartViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension CartViewController : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }

}
