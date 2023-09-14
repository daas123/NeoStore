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
class AddAddressController: UIViewController ,UITextFieldDelegate, UITextViewDelegate{
    let viewModel = AddAddressViewModel()
    var originalViewYPosition: CGFloat = 0.0
    @IBOutlet weak var addressMainTextview: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var AddressCityLandmark: UITextField!
    @IBOutlet weak var addressCity: UITextField!
    @IBOutlet weak var addressState: UITextField!
    @IBOutlet weak var addressZipCode: UITextField!
    @IBOutlet weak var addressCountry: UITextField!
    
    @IBOutlet weak var scrollviewtopConstrain: NSLayoutConstraint!
    @IBOutlet weak var scrollviewbottomConstrain: NSLayoutConstraint!
    
    let userDefaults = UserDefaults.standard
    let arrAddDetails = [adddetails(firstcol: "CITY", seconcol: "STATE"),
                         adddetails(firstcol: "ZIPCODE", seconcol: "COUNTRY")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Address"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        // for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
        // Do any additional setup after loading the view.
        AddressCityLandmark.delegate = self
        addressCity.delegate = self
        addressState.delegate = self
        addressZipCode.delegate = self
        addressCountry.delegate = self
        
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
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

    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
               activeTextField != addressMainTextview ,activeTextField != AddressCityLandmark  {
                UIView.animate(withDuration: 0.3) {
                    var contentInset:UIEdgeInsets = self.scrollview.contentInset
                            contentInset.bottom = keyboardFrame.size.height + 20
                    self.scrollview.contentInset = contentInset
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.scrollview.contentInset = UIEdgeInsets.zero
        }
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
