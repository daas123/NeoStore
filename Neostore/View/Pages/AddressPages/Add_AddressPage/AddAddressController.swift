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
    
    static func loadFromNib()-> UIViewController{
        return AddAddressController(nibName: navigationVCConstant.addAddressVC, bundle: nil)
    }
    
    @IBAction func SaveAddress(_ sender: UIButton) {
        let address = addressMainTextview.text ?? txtfieldValConst.emptyStr
            let landmark = AddressCityLandmark.text ?? txtfieldValConst.emptyStr
            let city = addressCity.text ?? txtfieldValConst.emptyStr
            let state = addressState.text ?? txtfieldValConst.emptyStr
            let zipCodeText = addressZipCode.text ?? txtfieldValConst.emptyStr
            let country = addressCountry.text ?? txtfieldValConst.emptyStr
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
            addressCountry.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
