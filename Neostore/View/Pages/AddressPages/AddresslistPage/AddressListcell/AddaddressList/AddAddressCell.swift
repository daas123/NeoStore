//
//  AddAddressCell.swift
//  Neostore
//
//  Created by Neosoft on 10/09/23.
//

import UIKit

class AddAddressCell: UITableViewCell {

    @IBOutlet weak var addaddressview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        addaddressview.layer.borderWidth = 2
        addaddressview.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
