//
//  ProductTableViewCell.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet var productListrating: [UIImageView]!
    
    
    @IBOutlet weak var productCost: UILabel!
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
    
    func setRating(_ rating: Int) {
        var count = 1
        for i in productListrating {
            if rating >= count {
                i.image = UIImage(systemName: "star.fill")
                count += 1
            }else{
                i.image = UIImage(systemName: "star")
            }
        }
    }

}
