//
//  ProductDetailsVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/2/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

class ProductDetailsVController: UIViewController {

    var prodname:String?
    var prodprice:Double?
    var proddesc: String?
    var prodspecs:String?
    var productphoto:UIImage?
    var productImgName:String?
    
    @IBOutlet weak var toARButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var specsLabel: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceNumberLabel: UILabel!
    @IBOutlet weak var dollarSignLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet var productdesc: UITextView!
    
    @IBOutlet var productspec: UITextView!
    
    @IBOutlet weak var productImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        toARButton.titleLabel?.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        specsLabel.adjustsFontSizeToFitWidth = true
        addToCartBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontSizeToFitWidth = true
        priceNumberLabel.adjustsFontSizeToFitWidth = true
        dollarSignLabel.adjustsFontSizeToFitWidth = true
        productNameLabel.adjustsFontSizeToFitWidth = true
        
       
        productImage.image = productphoto!
        productNameLabel.text = prodname
        productdesc.text = proddesc
        productspec.text = prodspecs
        priceNumberLabel.text = String(format:"%f", prodprice!)
        
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
         guard let id = segue.identifier else {return}
                if( id == "CameraSegue"){
                    
                    if let vd = segue.destination as? ARVController {
                       vd.prodimgname = productImgName
        //                vd.passEvent(e: ProductArr[row ?? 0])
                    }
                    
                }
            }
    
    

}
