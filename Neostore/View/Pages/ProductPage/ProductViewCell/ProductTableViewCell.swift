//
//  ProductTableViewCell.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ProductRatings: UILabel!
    @IBOutlet weak var ProductCost: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
