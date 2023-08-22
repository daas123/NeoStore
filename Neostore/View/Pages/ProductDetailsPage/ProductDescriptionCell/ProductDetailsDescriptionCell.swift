//
//  ProductDetailsDescriptionCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ProductDetailsDescriptionCell: UITableViewCell {

    // content outlet
    @IBOutlet weak var ProductDetailsDecriptioncontentview: UIView!
    // product description text
    @IBOutlet weak var ProductDetailsDescriptionText: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
