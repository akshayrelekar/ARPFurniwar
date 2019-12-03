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
    
    
    @IBOutlet weak var productImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = productphoto!
        
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
