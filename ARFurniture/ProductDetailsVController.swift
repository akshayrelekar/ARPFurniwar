//
//  ProductDetailsVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/2/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit

class ProductDetailsVController: UIViewController {

    var productphoto:UIImage?
    @IBOutlet weak var toARButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var specsLabel: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceNumberLabel: UILabel!
    @IBOutlet weak var dollarSignLabel: UILabel!
    
    
    @IBOutlet weak var productImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = productphoto!
        toARButton.titleLabel?.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        specsLabel.adjustsFontSizeToFitWidth = true
        addToCartBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontSizeToFitWidth = true
        priceNumberLabel.adjustsFontSizeToFitWidth = true
        dollarSignLabel.adjustsFontSizeToFitWidth = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
