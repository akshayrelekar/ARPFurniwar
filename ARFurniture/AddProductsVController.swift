//
//  AddProductsVController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/3/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

var TableArray:[Product] = [Product]()
var BedArray:[Product] = [Product]()
var ChairArray:[Product] = [Product]()
var SofaArray:[Product] = [Product]()
var BeanArray:[Product] = [Product]()
class AddProductsVController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    

    var totalproducts:[Product] = [Product]()
    
    @IBOutlet var picker: UIPickerView!
     var pickerData: [String] = [String]()
    var selectedCategory: String = ""
    @IBOutlet var CategoryName: UILabel!
    
    @IBOutlet var ProductName: UILabel!
    
    @IBOutlet var ProductDesc: UILabel!
    
    @IBOutlet var ProductSpec: UILabel!
    
    @IBOutlet var ProductCost: UILabel!
    
    
    @IBOutlet var prodnametext: UITextField!
    
    @IBOutlet var proddesctext: UITextView!
    
    @IBOutlet var prodspectext: UITextView!
    
    @IBOutlet var prodcosttext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.picker.delegate = self
    self.picker.dataSource = self
        
    NotificationCenter.default.addObserver(self, selector: #selector(AddProductsVController.keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddProductsVController.keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddProductsVController.tapped(tapGesture:)))
        view.addGestureRecognizer(tapGesture)
    CategoryName.adjustsFontSizeToFitWidth = true
    ProductName.adjustsFontSizeToFitWidth = true
    ProductDesc.adjustsFontSizeToFitWidth = true
    ProductSpec.adjustsFontSizeToFitWidth = true
    ProductCost.adjustsFontSizeToFitWidth = true
        
    pickerData = ["Beds", "Tables", "Chairs/Stools", "Sofa Sets", "Bean Bags"]
    
        let fetchRequest:NSFetchRequest<Product> = Product.fetchRequest()
        do{
            
            let e = try PersistentService.context.fetch(fetchRequest)
            totalproducts = e
            
        }catch{
            print("cannot fetch the saved event")
        }
        
        for product in totalproducts{
                          if(product.categoryname == "Tables"){
                              TableArray.append(product)
                          }
                          else if(product.categoryname == "Chairs/Stools"){
                              ChairArray.append(product)
                          }
                          else if(product.categoryname == "Beds"){
                              BedArray.append(product)
                          }
                          else if(product.categoryname == "Sofa Sets"){
                              SofaArray.append(product)
                          }
                          else if(product.categoryname == "Bean Bags"){
                              BeanArray.append(product)
                          }
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedCategory = pickerData[row]
        print("picker - \(pickerData[row])")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onAddProducts(_ sender: Any) {
       let name = prodnametext.text
       let desc = proddesctext.text
       let spec = prodspectext.text
       let cost = prodcosttext.text
        
            let p = Product(context:PersistentService.context)
           
            p.categoryname = selectedCategory
            p.productName =  name
            p.productDesc = desc
            p.productSpec = spec
            p.productCost = Double(cost!) as! Double
            //    Double(round(x/10000))
        
            switch selectedCategory {
                case "Tables":
                    p.productId = Int16(totalproducts.count)
                    
                    p.productImage = UIImage(named: "t\(TableArray.count).png")?.pngData()
                    p.productImageName = "t\(TableArray.count)"
                    TableArray.append(p)
                    print("$$$",p.productImage)
                    print("Persisted - \(TableArray.count)")
                    PersistentService.saveContext()
                    
                break
                case "Beds":
                    p.productId = Int16(totalproducts.count)
                    p.productImage = UIImage(named: "b\(BedArray.count).png")?.pngData()
                    p.productImageName = "b\(BedArray.count)"
                    BedArray.append(p)
                     print("$$$",p.productImage)
                    PersistentService.saveContext()
                    break
                case "Chairs/Stools":
                     p.productId = Int16(totalproducts.count)
                     p.productImage = UIImage(named: "c\(ChairArray.count).png")?.pngData()
                     p.productImageName = "c\(ChairArray.count)"
                    ChairArray.append(p)
                     print("$$$",p.productImage)
                    PersistentService.saveContext()
                    break
                case "Sofa Sets":
                     p.productId = Int16(totalproducts.count)
                     p.productImage = UIImage(named: "s\(SofaArray.count).png")?.pngData()
                      p.productImageName = "s\(SofaArray.count)"
                    SofaArray.append(p)
                     print("$$$",p.productImage)
                    PersistentService.saveContext()
                    break
                case "Bean Bags":
                     p.productId = Int16(totalproducts.count)
                     p.productImage = UIImage(named: "bb\(BeanArray.count).png")?.pngData()
                    p.productImageName = "bb\(BeanArray.count)"
                    BeanArray.append(p)
                    PersistentService.saveContext()
                    break
                
            default:
                return
        }
//
        let alert = UIAlertController(title: "✅", message: "Product Added Successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: .none))
        self.present(alert, animated: true, completion: nil)
          }
        
        
       
        
    
    

}
