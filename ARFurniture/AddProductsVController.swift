//
//  AddProductsVController.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/3/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

var TableArray:[Product] = [Product]()
var BedArray:[Product] = [Product]()
var ChairArray:[Product] = [Product]()
var SofaArray:[Product] = [Product]()
var BeanArray:[Product] = [Product]()
class AddProductsVController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
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
        CategoryName.adjustsFontSizeToFitWidth = true
        ProductName.adjustsFontSizeToFitWidth = true
        ProductDesc.adjustsFontSizeToFitWidth = true
        ProductSpec.adjustsFontSizeToFitWidth = true
        
        ProductCost.adjustsFontSizeToFitWidth = true
        
        pickerData = ["Beds", "Tables", "Chairs/Stools", "Sofa Sets", "Bean Bags"]
       
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
        
            switch selectedCategory {
                case "Tables":
                    p.productId = Int16(TableArray.count)
                    p.productImage = UIImage(named: "t\(TableArray.count).png")?.pngData()
                    TableArray.append(p)
                    print("Persisted - \(TableArray.count)")
                    PersistentService.saveContext()
                break
                case "Beds":
                    p.productId = Int16(BedArray.count)
                //  p.productImage = "t\(TableArray.count)"
                    BedArray.append(p)
                    PersistentService.saveContext()
                    break
                case "Chairs/Stools":
                     p.productId = Int16(ChairArray.count)
                //  p.productImage = "t\(TableArray.count)"
                    ChairArray.append(p)
                    PersistentService.saveContext()
                    break
                case "Sofa Sets":
                     p.productId = Int16(SofaArray.count)
                //  p.productImage = "t\(TableArray.count)"
                    SofaArray.append(p)
                    PersistentService.saveContext()
                    break
                case "Bean Bags":
                     p.productId = Int16(BeanArray.count)
                //  p.productImage = "t\(TableArray.count)"
                    BeanArray.append(p)
                    PersistentService.saveContext()
                    break
                
            default:
                return
        }
//
        }
        
       
        
    
    

}
