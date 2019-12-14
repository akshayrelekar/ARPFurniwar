//
//  SignInController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 11/30/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

class SignInControllerrrr: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

//    var emailaddress:String?
//    var pswd:String?
//    var name:String?
//    var mobile:String?
    var sex:String?
    let imagePicker = UIImagePickerController()
    var StoredImg:NSManagedObject?
    var user:User?
    var u:[User] = [User]()
    @IBOutlet var ImageView: UIImageView!
    
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var fullNametxt: UITextField!
    @IBOutlet weak var mobiletxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignInController.tapped(tapGesture:)))
        view.addGestureRecognizer(tapGesture)
       
        NotificationCenter.default.addObserver(self, selector: #selector(SignInController.keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInController.keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        do{
            let e = try PersistentService.context.fetch(fetchRequest)
            u = e
            
        }catch{
            print("cannot fetch the saved event")
        }
    }
    
    @objc func tapped(tapGesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBOutlet var segment: UISegmentedControl!
    
    
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
         guard let iden = segue.identifier else {return}
                if(iden == "loginPage" ){
                    if let vd = segue.destination as? LoginController{
//                       
                    }
                }
    }
    
    @IBAction func LoadImage(_ sender: UIButton) {
        
        if(UIDevice.current.userInterfaceIdiom == .pad){
            let imagepicker =  UIImagePickerController()
            imagepicker.delegate = self
            
            let actionsheet = UIAlertController(title: "Choose your photo from",message: nil, preferredStyle: .actionSheet)
            
            actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagepicker.sourceType = .photoLibrary
                self.present(imagepicker, animated: true, completion: nil)
            }))
            
            actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                imagepicker.sourceType = .camera
                self.present(imagepicker, animated: true, completion: nil)
            }))
            
            actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            actionsheet.popoverPresentationController?.sourceView = self.view
            actionsheet.popoverPresentationController?.sourceRect = sender.frame
            self.present(actionsheet, animated: true, completion: nil)
        }
        else{
         
            let imagepicker =  UIImagePickerController()
            imagepicker.delegate = self

            let actionsheet = UIAlertController(title: "Choose your photo from",message: nil, preferredStyle: .actionSheet)

            actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagepicker.sourceType = .photoLibrary
                self.present(imagepicker, animated: true, completion: nil)
            }))
            
            actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                imagepicker.sourceType = .camera
                self.present(imagepicker, animated: true, completion: nil)
            }))

            actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionsheet, animated: true, completion: nil)
        }
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
    
    
//     func textFieldDidEndEditing(_ textField: UITextField) {
//
//        switch textField.tag{
//        case 1:
//            let email = textField.text!
//            if(!email.isEmpty){
//                let validEmail = email.isValidEmail()
//                guard validEmail==true else{
//                    print("Inside tag 1")
//                    InvalidError(textField: textField)
//                    return
//                }
//            }
//            emailaddress = email
//            print(emailaddress)
//            break
//        case 2:
//            pswd = textField.text
//            print(pswd)
//            break
//        case 3:
//            name = textField.text
//            print(name)
//            break
//        case 4:
//            let phone = textField.text
//
//            if(!phone!.isEmpty){
//                let validPhn = phone!.isPhone()
//                           guard validPhn==true else{
//                               InvalidError(textField: textField)
//                               return
//                           }
//                       }
//                       mobile = phone
//                       print(mobile)
//            break
//
//        default:
//            return
//        }
//    }

//    func InvalidError(textField:UITextField)->Void{
//           print("Inside InvalidError")
//           var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
//           topWindow?.rootViewController = UIViewController()
//           topWindow?.windowLevel = UIWindow.Level.alert + 1
//           var alert = UIAlertController();
//           if(textField.tag == 2){
//               alert = UIAlertController(title: "Alert", message: "Invalid Phone number", preferredStyle: .alert)
//           }
//           else if (textField.tag == 3){
//               alert = UIAlertController(title: "Alert", message: "Invalid Email Id", preferredStyle: .alert)
//           }
//           alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
//               topWindow = nil // if you want to hide the topwindow then use this
//               
//           })
//           topWindow?.makeKeyAndVisible()
//           topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//       }
    
    
    @IBAction func onCreateAccount(_ sender: Any) {
        let email = emailtxt.text
        let password = passwordtxt.text
        let fullName = fullNametxt.text
        let phone = mobiletxt.text
        let sex =  segment.titleForSegment(at: segment.selectedSegmentIndex)
                  print("gender -- \(sex!)")
        if(!isPhone(phone: phone!)){
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Phone", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
            mobiletxt.text = ""
            self.present(alert, animated: true, completion: nil)
        }
        if(!isValidEmail(email: email!)){
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
            emailtxt.text = ""
            self.present(alert, animated: true, completion: nil)
        }
        else if(fullName!.isEmpty || phone!.isEmpty || email!.isEmpty || password!.isEmpty)
        {
            if(fullName!.isEmpty){
                let alert = UIAlertController(title: "Alert", message: "Enter Name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                self.present(alert, animated: true, completion: nil)
            }
            else if(phone!.isEmpty){
                let alert = UIAlertController(title: "Alert", message: "Enter Phone", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                self.present(alert, animated: true, completion: nil)
            }
            else if(email!.isEmpty){
                let alert = UIAlertController(title: "Alert", message: "Enter Email", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                self.present(alert, animated: true, completion: nil)
            }
            else if(password!.isEmpty){
                let alert = UIAlertController(title: "Alert", message: "Enter Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            user = User(context:PersistentService.context)
            user!.userId = Int16(0)
            user!.fullName = fullName
            user!.phone = phone
            user!.emailaddress = email
            user!.password = password
            user!.gender = sex
            user!.phone = phone
//            user.profimg = StoredImg
            PersistentService.saveContext()
            let alert = UIAlertController(title: "✅", message: "Account Created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .destructive, handler: {
                action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
            //self.performSegue(withIdentifier: "loginPage", sender: self)
            
//            let alert = UIAlertController(title: "✅", message: "Account Created", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
//            self.present(alert, animated: true, completion: nil)
        }
        
//        if (!name!.isEmpty && !mobile!.isEmpty && !emailaddress!.isEmpty && !pswd!.isEmpty){
//            user = User(context:PersistentService.context)
//            user!.userId = Int16(0)
//            user!.fullName = name!
//            user!.phone = mobile!
//            user!.emailaddress = emailaddress!
//            user!.password = pswd!
//            user!.gender = sex!
//            user!.phone = mobiletxt.text
//            user.profimg = StoredImg
//            PersistentService.saveContext()
//            self.performSegue(withIdentifier: "LoginPage", sender: self)
//            var emailaddress = ""
//            var pswd = ""
//            var name = ""
//            var mobile = ""
//            
//            var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
//            topWindow?.rootViewController = UIViewController()
//            topWindow?.windowLevel = UIWindow.Level.alert + 1
//            
//            
//            let alert = UIAlertController(title: "✅", message: "User Added Successfully", preferredStyle: .alert)
//            
//            
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
//                
//                topWindow = nil // if you want to hide the topwindow then use this
//                
//            })
//            
//            topWindow?.makeKeyAndVisible()
//            topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//                }
//                else{
//                    let alert = UIAlertController(title: "Alert", message: "Enter All the values", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
//                    self.present(alert, animated: true, completion: nil)
//                   var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
//                    topWindow?.rootViewController = UIViewController()
//                    topWindow?.windowLevel = UIWindow.Level.alert + 1
//                    let alert = UIAlertController(title: "Alert", message: "Enter all values", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
//
//                        topWindow = nil // if you want to hide the topwindow then use this
//                    })
//
//                    topWindow?.makeKeyAndVisible()
//                    topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//                }
    }
    
    func isPhone(phone: String)->Bool {
        // 123-456-7890
        // (123) 456-7890
        // 123 456 7890
        // 123.456.7890
        // +91 (123) 456-7890
        print("Inside isPhone")
        let phoneRegex = "^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]\\d{3}[\\s.-]\\d{4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return  predicate.evaluate(with: phone)
    }
    
    @objc func isValidEmail(email: String) -> Bool {
        print("inside email valid")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}


