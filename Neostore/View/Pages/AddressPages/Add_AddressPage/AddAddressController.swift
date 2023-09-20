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
class AddAddressController: BaseViewController {
    
    // MARK: File Variable
    let viewModel = AddAddressViewModel()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var addressMainTextview: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var AddressCityLandmark: UITextField!
    @IBOutlet weak var addressCity: UITextField!
    @IBOutlet weak var addressState: UITextField!
    @IBOutlet weak var addressZipCode: UITextField!
    @IBOutlet weak var addressCountry: UITextField!
    @IBOutlet weak var scrollviewtopConstrain: NSLayoutConstraint!
    @IBOutlet weak var scrollviewbottomConstrain: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        baseScrollView = scrollview
        setTitle(titleString: pageTitleConstant.addAddress)
        setTapGesture()
        setDeligate()
    }
    
    func setTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setDeligate(){
        AddressCityLandmark.delegate = self
        addressCity.delegate = self
        addressState.delegate = self
        addressZipCode.delegate = self
        addressCountry.delegate = self
    }
    
    @IBAction func SaveAddress(_ sender: UIButton) {
        let address = addressMainTextview.text ?? ""
            let landmark = AddressCityLandmark.text ?? ""
            let city = addressCity.text ?? ""
            let state = addressState.text ?? ""
            let zipCodeText = addressZipCode.text ?? ""
            let country = addressCountry.text ?? ""
        viewModel.addAddressData(address: address, landmark: landmark, city: city, state:state , zipCode: Int(zipCodeText) ?? 0 , country: country){
            responce,msg in
            if responce{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.showAlert(msg: msg)
            }
        }
    }
}

extension AddAddressController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case addressMainTextview:
            AddressCityLandmark.becomeFirstResponder()
        case AddressCityLandmark:
            addressCity.becomeFirstResponder()
        case addressCity:
            addressState.becomeFirstResponder()
        case addressState:
            addressZipCode.becomeFirstResponder()
        case addressZipCode:
            addressCountry.becomeFirstResponder()
        case addressCountry:
            addressCountry.resignFirstResponder() // Hide the keyboard when pressing return on the last field
        default:
            break
        }
        return true
    }
}
