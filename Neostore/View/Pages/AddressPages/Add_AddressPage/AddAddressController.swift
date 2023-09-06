//
//  AddAddressController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
struct adddetails{
    let firstcol:String
    let seconcol:String
}
class AddAddressController: UIViewController {
    let viewModel = AddAddressViewModel()
    
    @IBOutlet weak var addressMainTextview: UITextView!
    @IBOutlet weak var AddressCityLandmark: UITextField!
    @IBOutlet weak var addressCity: UITextField!
    @IBOutlet weak var addressState: UITextField!
    @IBOutlet weak var addressZipCode: UITextField!
    @IBOutlet weak var addressCountry: UITextField!
    
    
    let userDefaults = UserDefaults.standard
    let arrAddDetails = [adddetails(firstcol: "CITY", seconcol: "STATE"),
                         adddetails(firstcol: "ZIPCODE", seconcol: "COUNTRY")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Address"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SaveAddress(_ sender: UIButton) {
        let address = addressMainTextview.text ?? ""
            let landmark = AddressCityLandmark.text ?? ""
            let city = addressCity.text ?? ""
            let state = addressState.text ?? ""
            let zipCodeText = addressZipCode.text ?? ""
            let country = addressCountry.text ?? ""
        viewModel.addAddressData(address: address, landmark: landmark, city: city, state:state , zipCode: Int(zipCodeText) ?? 0 , country: country){
            responce in
            if responce{
                self.navigationController?.pushViewController(AddressListViewController(nibName:"AddressListViewController", bundle: nil), animated: true)
                self.showAlert(msg: "Address Added to List")
            }
        }
    }
    

}
