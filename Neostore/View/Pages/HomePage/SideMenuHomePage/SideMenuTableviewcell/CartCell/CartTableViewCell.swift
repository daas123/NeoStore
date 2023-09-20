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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cartButtonAcion(_ sender: UIButton) {
    }
    
}
