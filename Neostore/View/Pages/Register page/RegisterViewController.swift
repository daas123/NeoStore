//
//  RegisterViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    var originalViewYPosition: CGFloat = 0.0
    @IBOutlet var registerDetailsView: [UIView]!
    
    
    // user registration feilds
    
    @IBOutlet weak var registerFirstname: UITextField!
    @IBOutlet weak var registerlastname: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField?
    @IBOutlet weak var registerConformPassword: UITextField!
    @IBOutlet weak var registerPhoneNumber: UITextField?
    var gender:String?
    
    // male button and female button
    
    @IBOutlet weak var registerFemaleradio: UIButton!
    @IBOutlet weak var registerMaleRadio: UIButton!
    
    // chk box
    
    @IBOutlet weak var registerchkBox: UIButton!
    
    // view model
    let viewModel = RegisterViewModel()
    var chkbtn = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.09411764706, blue: 0.05490196078, alpha: 1)
        
        title = "Register"
        for registerViews in registerDetailsView{
            registerViews.layer.borderWidth = 2
            registerViews.layer.borderColor = UIColor.white.cgColor
        }
        
        
        // for radio button of register page
        registerMaleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        registerMaleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        registerFemaleradio.setImage(UIImage(systemName: "circle"), for: .normal)
        registerFemaleradio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        
        registerchkBox.setImage(UIImage(systemName: "square"), for: .normal)
        registerchkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        
        
        
        // for keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
        
        registerFirstname.delegate = self
        registerFirstname.tag = 0
        registerlastname.delegate = self
        registerlastname.tag = 1
        registerEmail.delegate = self
        registerEmail.tag = 2
        
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
               activeTextField != registerFirstname && activeTextField != registerlastname {
                UIView.animate(withDuration: 0.3) {
                    // Move the view upward by the keyboard's height
                    self.view.frame.origin.y = self.originalViewYPosition - keyboardHeight + 40
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func radioTapped(_ sender: UIButton) {
        if sender == registerMaleRadio{
            gender = "M"
            registerMaleRadio.isSelected = true
            registerFemaleradio.isSelected = false
        }
        else{
            gender = "F"
            registerMaleRadio.isSelected = false
            registerFemaleradio.isSelected = true
        }
    }
    
    @IBAction func checkbutton(_ sender: UIButton) {
        if chkbtn {
            registerchkBox.isSelected = true
            chkbtn = false
            
            
        }else{
            registerchkBox.isSelected = false
            chkbtn = true
            
        }
    }
    
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        viewModel.registervalidation(Fname: registerFirstname.text ?? "", Lname: registerlastname.text ?? "", Email: registerEmail.text ?? "", Pass: registerPassword?.text ?? "", Cpass: registerPassword?.text ?? "", Gender: gender ?? "F", Phone: registerPhoneNumber?.text ?? "", chkBox: registerchkBox.isSelected ?? false){
            (validateBool , resultStrng) in
            DispatchQueue.main.async {
                if validateBool{
                    self.navigationController?.pushViewController(LoginViewController(nibName:"LoginViewController", bundle: nil), animated: true)
                    self.showAlert(msg: resultStrng)
                }else{
                    self.showAlert(msg: resultStrng)
                }
            }
            
        }
    }
}
