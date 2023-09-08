//
//  ProductDetailsTitleCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ProductDetailsTitleCell: UITableViewCell {

    
    @IBOutlet var productratingimages: [UIImageView]!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    
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
        for i in productratingimages {
            if rating >= count {
                i.image = UIImage(systemName: "star.fill")
                count += 1
            }else{
                i.image = UIImage(systemName: "star")
            }
        }
    }
}
