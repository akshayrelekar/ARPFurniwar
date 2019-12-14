//
//  CartVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/12/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import Braintree

class CartVControllerr: UIViewController {

    var braintreeclient: BTAPIClient?
    private var hud : MBProgressHUD!
    
    @IBOutlet weak var cartView: UIView!
    @IBAction func payPressed(_ sender: UIButton) {
        
        let payPalDriver = BTPayPalDriver(apiClient: braintreeclient!)
               payPalDriver.viewControllerPresentingDelegate = self
               payPalDriver.appSwitchDelegate = self
               
               let request = BTPayPalRequest(amount: "3")
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
       
    }
}

extension CartVControllerr : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

extension CartVControllerr : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
