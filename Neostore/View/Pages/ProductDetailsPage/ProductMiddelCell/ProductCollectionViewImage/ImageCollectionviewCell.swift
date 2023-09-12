//
//  ImageCollectionviewCell.swift
//  Neostore
//
//  Created by Neosoft on 30/08/23.
//

import UIKit

class ImageCollectionviewCell: UICollectionViewCell {

    @IBOutlet weak var productDetailsImagecell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productDetailsImagecell.layer.borderColor = UIColor.gray.cgColor
        productDetailsImagecell.layer.borderWidth = 1
    }
    func setBorder(){
        productDetailsImagecell.layer.borderColor = UIColor.red.cgColor
        productDetailsImagecell.layer.borderWidth = 1
    }
    
    func clearBorder(){
        productDetailsImagecell.layer.borderColor = UIColor.gray.cgColor
        productDetailsImagecell.layer.borderWidth = 1
    }

}
