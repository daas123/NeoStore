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
    var originalViewYPosition: CGFloat = 0.0
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        // for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
               activeTextField != addressMainTextview  {
                UIView.animate(withDuration: 0.3) {
                    // Move the view upward by the keyboard's height
                    self.view.frame.origin.y = self.originalViewYPosition - keyboardHeight + 30
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.view.frame.origin.y = self.originalViewYPosition
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
            responce in
            if responce{
                self.navigationController?.pushViewController(AddressListViewController(nibName:"AddressListViewController", bundle: nil), animated: true)
                self.showAlert(msg: "Address Added to List")
            }
        }
    }
    

}
