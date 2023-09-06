//
//  CartOrderCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

class CartOrderCell: UITableViewCell {

    weak var cartDeligate : CartAction?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cartOrderAction(_ sender: UIButton) {
        cartDeligate?.pushOrderViewController()
    }
    
}
