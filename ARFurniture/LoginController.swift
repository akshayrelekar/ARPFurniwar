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

    @IBOutlet weak var userNametext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    var username:String = ""
    var password:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNametext.text = "payal@gmail.com"
        passwordtext.text = "payal"
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            for u in users{
                if(u.emailaddress == username){
                    let pswd = u.password
                    if(pswd == password){
                        print("User logged in")
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Alert", message: "Incorrect Username or password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                        self.present(alert, animated: true, completion: nil)
                          }
                }
            }
        }
      
      
        
    }
}
