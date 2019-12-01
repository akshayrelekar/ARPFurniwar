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

    var username:String?
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        do{
            let u = try PersistentService.context.fetch(fetchRequest)
            users = u
        }catch{
            print("cannot fetch the saved user")
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
   
    
        
        if(!username!.isEmpty && !password!.isEmpty){
            for u in users{
                if(u.emailaddress == username){
                    let pswd = u.password
                    if(pswd == password){
                        print("User logged in")
                    }
                    else{
                              var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                                                 topWindow?.rootViewController = UIViewController()
                                                 topWindow?.windowLevel = UIWindow.Level.alert + 1
                                                 
                                                 
                                                 let alert = UIAlertController(title: "Alert", message: "Incorrect Username or password", preferredStyle: .alert)
                                                 
                                                 
                                                 alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                                                     
                                                     topWindow = nil // if you want to hide the topwindow then use this
                                                     
                                                 })
                                                 
                                                 topWindow?.makeKeyAndVisible()
                                                 topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                          }
                }
            }
        }
        else if(username!.isEmpty || password!.isEmpty)
        {
            print("Inside empty loop")
            var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                               topWindow?.rootViewController = UIViewController()
                               topWindow?.windowLevel = UIWindow.Level.alert + 1
                               
                               
                               let alert = UIAlertController(title: "Alert", message: "Username or Password cannot be empty", preferredStyle: .alert)
                               
                               
                               alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                                   
                                   topWindow = nil // if you want to hide the topwindow then use this
                                   
                               })
                               
                               topWindow?.makeKeyAndVisible()
                               topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
      
        
    }
}
