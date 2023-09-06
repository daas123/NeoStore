//
//  OrderIdCell.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class OrderIdCell: UITableViewCell {

    @IBOutlet weak var orderListOrderId: UILabel!
    
    @IBOutlet weak var orderListTotalCost: UILabel!
    
    @IBOutlet weak var orderListDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
