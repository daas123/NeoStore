//
//  ProductDetailsCartCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ProductDetailsCartCell: UITableViewCell {

    @IBOutlet weak var CartProductQuantity: UILabel!
    @IBOutlet weak var CartProductImage: UIImageView!
    @IBOutlet weak var CartProductName: UILabel!
    @IBOutlet weak var CartProuductTotalCost: UILabel!
    @IBOutlet weak var cartProductCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
