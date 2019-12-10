//
//  CategoriesTabVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/1/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTabVController: UIViewController {

    var Allproducts:[Product] = []
    var TableArr:[Product] = []
    var BedArr:[Product] = []
    var ChairArr:[Product] = []
    var SofaArr:[Product] = []
    var BeanBagArr:[Product] = []
    @IBOutlet var categoriesTab: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //let overlayframe: CGRect = CGRect(x: 0, y: 0, width: categoriesTab.frame.width, height: categoriesTab.frame.height)
        //let overlayView: UIView = UIView(frame: overlayframe)
        //overlayView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        //categoriesTab.addSubview(overlayView)
        // Do any additional setup after loading the view.
        
        let fetchRequest:NSFetchRequest<Product> = Product.fetchRequest()
                 do{
                     let e = try PersistentService.context.fetch(fetchRequest)
                     Allproducts = e
                     
                 }catch{
                     print("cannot fetch the saved event")
                 }
        for product in Allproducts{
                   if(product.categoryname == "Tables"){
                       TableArr.append(product)
                   }
                   else if(product.categoryname == "Chairs/Stools"){
                       ChairArr.append(product)
                   }
                   else if(product.categoryname == "Beds"){
                       BedArr.append(product)
                   }
                   else if(product.categoryname == "Sofa Sets"){
                       SofaArr.append(product)
                   }
                   else if(product.categoryname == "Bean Bags"){
                       BeanBagArr.append(product)
                   }
               }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("all products count \(Allproducts.count)")
       
        
        guard let iden = segue.identifier else {return}
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.topViewController
            if(iden == "TableSegue" ){
                 if(TableArr.count > 0){
            if let vd = targetController as? ProductListVController  {
                print("TableArr count \(TableArr.count)")
               
                vd.SegueProduct = TableArr
                }
                else{
                    print("No tables in TableArr")
                }
            }
        }
        else if(iden == "BedSegue" ){
                if(BedArr.count > 0){
            if let vd = targetController as? ProductListVController  {
                vd.SegueProduct = BedArr
                }
                else{
                    print("No Beds in BedsArr")
                }
            }
        }
        else if(iden == "ChairSegue" ){
                 if(ChairArr.count > 0){
            if let vd = targetController as? ProductListVController  {
                vd.SegueProduct = ChairArr
                }
                else{
                    print("No chairs in ChairArr")
                }
            }
        }
        else if(iden == "SofaSegue" ){
                 if(SofaArr.count > 0){
            if let vd = targetController as? ProductListVController  {
                vd.SegueProduct = SofaArr
                }
                else{
                    print("No sofas in SofaArr")
                }
            }
        }
       else if(iden == "BeanBagSegue" ){
                 if(BeanBagArr.count > 0){
            if let vd = targetController as? ProductListVController  {
                vd.SegueProduct = BeanBagArr
                }
                else{
                    print("No Bean Bag in BeanBagArr")
                }
            }
        }
    
    }
  
}
