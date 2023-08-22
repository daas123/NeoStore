//
//  ProductDetailsImageCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class ProductDetailsImageCell: UITableViewCell {
    
    
   //image
    
    @IBOutlet weak var ProductDetailsMianImage: UIImageView!
    @IBOutlet weak var ProductDetailsSubimageone: UIImageView!
    @IBOutlet weak var ProductDetailsSubimageTwo: UIImageView!
    @IBOutlet weak var ProductDetailsSubimageThree: UIImageView!
    
    //cost
    @IBOutlet weak var ProductDetailsCost: UILabel!
    
    // container outlet
    @IBOutlet weak var ProductDetailsImageContainerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func ProductDetailsShareButton(_ sender: UIButton) {
    }
}
