//
//  AddressListCell.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
protocol RemoveCell{
    func removeAddressCell(index : Int)
}

class AddressListCell: UITableViewCell {

    @IBOutlet weak var addressBackView: UIView!
    var cellindex : Int?
    var deligate : AddressListViewController?
    @IBOutlet weak var listcellview: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressLabelDetails: UILabel!
    
    @IBOutlet weak var radioButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        addressBackView.layer.cornerRadius = 5
        addressBackView.layer.borderColor = UIColor.gray.cgColor
        addressBackView.layer.borderWidth = 1
        radioButton.setImage(UIImage(systemName: ImageConstants.circle), for: .normal)
        radioButton.setImage(UIImage(systemName: ImageConstants.circle_fill), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setSelected(_ selected: Bool) {
           radioButton.isSelected = selected
       }
    
    
    @IBAction func closeButton(_ sender: UIButton) {
        deligate?.removeAddressCell(index: cellindex ?? 0)
    }
    
}
