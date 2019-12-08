//
//  LoginController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 11/30/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

var users:[User] = [User]()
class LoginController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var username:String = ""
    var password:String = ""
    var flag:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignInController.keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInController.keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignInController.tapped(tapGesture:)))
        view.addGestureRecognizer(tapGesture)
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        do{
            let u = try PersistentService.context.fetch(fetchRequest)
            users = u
        }catch{
            print("cannot fetch the saved user")
        }
    }
    
    @objc func tapped(tapGesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
     func add(u:User){
         print("Inside add func")
         users.append(u)
     }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let iden = segue.identifier else {return}
        if(iden == "AdminSegue" ){
            if let vd = segue.destination as? AddProductsVController  {
               print("Inside admin segue")
            }
        }
        else if(iden == "HomeSegue"){
            if let vd1 = segue.destination as? HomeVController{
                print("Inisde home segue")
            }
        }
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag{
        case 1:
            username = textField.text!
            break
        case 2:
            password = textField.text!
            break
       
        default:
            return
        }
    }
    
    
    
@IBAction func onLogin(_ sender: Any) {

    if(username.isEmpty || password.isEmpty)
    {
        print("Inside empty loop")
        let alert = UIAlertController(title: "Alert", message: "Username or password cannot be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
        self.present(alert, animated: true, completion: nil)
    }

     else if(!username.isEmpty && !password.isEmpty){
        print("I am here")
        print("--\(users.count)")
            for u in users{
                print(" $$ - \(u.emailaddress)")
                if(u.emailaddress == username){
                    let pswd = u.password
                    flag = 1
                    if(pswd == password){
                        if (username == "admin@gmail.com" && pswd == "admin"){
                            
                            self.performSegue(withIdentifier: "AdminSegue", sender: self)

                        }
                        else{
                             self.performSegue(withIdentifier: "HomeSegue", sender: self)
                        }
                    }
                    else{

                        let alert = UIAlertController(title: "Alert", message: "Incorrect Username or password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                        self.present(alert, animated: true, completion: nil)
                          }
                }
               
            }
        if(flag == 0){
            let alert = UIAlertController(title: "Alert", message: "Username does not exist", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
            self.present(alert, animated: true, completion: nil)
        }
        }



    }
}
