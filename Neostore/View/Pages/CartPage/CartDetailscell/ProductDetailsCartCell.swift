//
//  ProductDetailsCartCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ProductDetailsCartCell: UITableViewCell {
    // picker view    
    var index : Int?
    
    @IBOutlet weak var cartProductQuantity: UITextField!
    @IBOutlet weak var cartProductImage: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    @IBOutlet weak var cartProuductTotalCost: UILabel!
    @IBOutlet weak var cartProductCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func ProductCartDetailsCount(_ sender: UIButton) {
       
    }
}
