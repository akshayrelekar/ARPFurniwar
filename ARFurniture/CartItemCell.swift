//
//  CartItemCell.swift
//  ARFurniture
//
//  Created by Payal Zanwar on 12/10/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import Foundation

protocol CartItemDelegate {
    func updateCartItem(cell: CartItemCell, quantity: Int)
}

class CartItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var delegate: CartItemDelegate?
    var quantity: Int = 1
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//
//        incrementButton.layer.cornerRadius = 10
//        incrementButton.clipsToBounds = true
//
//        decrementButton.layer.cornerRadius = 10
//        decrementButton.clipsToBounds = true
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
            
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        decrementButton.isEnabled = quantity > 0
        decrementButton.backgroundColor = !decrementButton.isEnabled ? .gray : .black
        
        self.quantityLabel.text = String(describing: quantity)
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }
}
