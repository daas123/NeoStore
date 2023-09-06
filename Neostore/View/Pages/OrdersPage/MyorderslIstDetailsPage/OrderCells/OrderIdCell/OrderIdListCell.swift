//
//  OrderIdListCell.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class OrderIdListCell: UITableViewCell {

    
    
    @IBOutlet weak var orderDetailsCategory: UILabel!
    @IBOutlet weak var orderDetailsQnt: UILabel!
    @IBOutlet weak var orderDetailsTitle: UILabel!
    @IBOutlet weak var orderDetailsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
