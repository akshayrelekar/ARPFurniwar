//
//  SignInController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 11/30/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

class SignInController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    var emailaddress:String?
    var pswd:String?
    var name:String?
    var mobile:String?
    var sex:String?
    let imagePicker = UIImagePickerController()
    var StoredImg:NSManagedObject?
    var user:User?
    @IBOutlet var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // Do any additional setup after loading the view.
       
    }
    
    @IBOutlet var segment: UISegmentedControl!
    
    
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
         guard let iden = segue.identifier else {return}
                if(iden == "LoginPage" ){
                    if let vd = segue.destination as? LoginController{
//                                        vd.add(u: user )
        //                                vd.add(Uarray: UserArray[0], image:)
                       
//                        vd.tableView.reloadData()
                    }
                }
    }
    
    
 
    @IBAction func LoadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
               imagePicker.sourceType = .photoLibrary
               
               present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageView.contentMode = .scaleAspectFit
            ImageView.image = pickedImage
        
        
        dismiss(animated: true, completion: nil)
        let data = (ImageView.image)!.pngData()
        
        let proimg =  PersistentService.persistentContainer.viewContext
        StoredImg = NSEntityDescription.insertNewObject(forEntityName: "User", into: proimg)
        StoredImg!.setValue(data, forKey: "profimg")
        PersistentService.saveContext()
        print("Saved Image")
    }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
     func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag{
        case 1:
            let email = textField.text!
            if(!email.isEmpty){
                let validEmail = email.isValidEmail()
                guard validEmail==true else{
                    print("Inside tag 1")
                    InvalidError(textField: textField)
                    return
                }
            }
            emailaddress = email
            break
        case 2:
            pswd = textField.text
            break
        case 3:
            name = textField.text
            break
        case 4:
            let phone = textField.text
          
            if(!phone!.isEmpty){
                let validPhn = phone!.isPhone()
                           guard validPhn==true else{
                               InvalidError(textField: textField)
                               return
                           }
                       }
                       mobile = phone
                       print(mobile)
            break
        
        default:
            return
        }
    }

    func InvalidError(textField:UITextField)->Void{
           print("Inside InvalidError")
           var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
           topWindow?.rootViewController = UIViewController()
           topWindow?.windowLevel = UIWindow.Level.alert + 1
           var alert = UIAlertController();
           if(textField.tag == 2){
               alert = UIAlertController(title: "Alert", message: "Invalid Phone number", preferredStyle: .alert)
           }
           else if (textField.tag == 3){
               alert = UIAlertController(title: "Alert", message: "Invalid Email Id", preferredStyle: .alert)
           }
           alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
               topWindow = nil // if you want to hide the topwindow then use this
               
           })
           topWindow?.makeKeyAndVisible()
           topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
       }
    
    
    @IBAction func onCreateAccount(_ sender: Any) {
        let sex =  segment.titleForSegment(at: segment.selectedSegmentIndex)
                  print("gender -- \(sex!)")
        
        if (!name!.isEmpty && !mobile!.isEmpty && !emailaddress!.isEmpty && !pswd!.isEmpty){
      
                    user = User(context:PersistentService.context)
            user!.userId = Int16(0)
            user!.fullName = name!
            user!.phone = mobile!
            user!.emailaddress = emailaddress!
            user!.password = pswd!
            user!.gender = sex!
//                    user.profimg = StoredImg
                    
                    PersistentService.saveContext()
//                    self.performSegue(withIdentifier: "LoginPage", sender: self)
                  
                    
                    var emailaddress = ""
                    var pswd = ""
                    var name = ""
                    var mobile = ""
            
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    
                    
                    let alert = UIAlertController(title: "✅", message: "User Added Successfully", preferredStyle: .alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                        
                        topWindow = nil // if you want to hide the topwindow then use this
                        
                    })
                    
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                else{
                    var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                    topWindow?.rootViewController = UIViewController()
                    topWindow?.windowLevel = UIWindow.Level.alert + 1
                    
                    
                    let alert = UIAlertController(title: "Alert", message: "Enter all values", preferredStyle: .alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                        
                        topWindow = nil // if you want to hide the topwindow then use this
                        
                    })
                    
                    topWindow?.makeKeyAndVisible()
                    topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
        
    }
}

extension String{
    public func isPhone()->Bool {
        // 123-456-7890
        // (123) 456-7890
        // 123 456 7890
        // 123.456.7890
        // +91 (123) 456-7890
        print("Insdie isPhone")
        let phoneRegex = "^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]\\d{3}[\\s.-]\\d{4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        print("inside email valid")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    
}


