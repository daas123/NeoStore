//
//  CartTableViewCell.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TotalCartlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cartButtonAcion(_ sender: UIButton) {
    }
    
}
