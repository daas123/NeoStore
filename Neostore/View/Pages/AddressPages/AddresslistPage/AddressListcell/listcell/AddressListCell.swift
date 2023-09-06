//
//  AddressListCell.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
protocol SelectAddressCell{
}

class AddressListCell: UITableViewCell {

    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressLabelDetails: UILabel!
    
    @IBOutlet weak var radioButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        radioButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setSelected(_ selected: Bool) {
           radioButton.isSelected = selected
       }
    
}
