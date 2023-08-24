//
//  RegisterViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class RegisterViewController: UIViewController{
    
    
    @IBOutlet var registerDetailsView: [UIView]!
    
    
    // user registration feilds
    
    @IBOutlet weak var RegisterFirstname: UITextField!
    @IBOutlet weak var Registerlastname: UITextField!
    @IBOutlet weak var RegisterEmail: UITextField!
    @IBOutlet weak var RegisterPassword: UITextField?
    @IBOutlet weak var RegisterConformPassword: UITextField!
    @IBOutlet weak var RegisterPhoneNumber: UITextField?
    var Gender:String?
    
    // male button and female button
    
    @IBOutlet weak var RegisterFemaleradio: UIButton!
    @IBOutlet weak var RegisterMaleRadio: UIButton!
    
    // chk box
    
    @IBOutlet weak var RegisterchkBox: UIButton!
    
    // view model
    let viewModel = RegisterViewModel()
    var chkbtn = false
    var chkbuttonvalue : Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        for registerViews in registerDetailsView{
            registerViews.layer.borderWidth = 1
            registerViews.layer.borderColor = UIColor.white.cgColor
        }
        
        
        // for radio button of register page
        RegisterMaleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        RegisterMaleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        RegisterFemaleradio.setImage(UIImage(systemName: "circle"), for: .normal)
        RegisterFemaleradio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
        
        RegisterchkBox.setImage(UIImage(systemName: "square"), for: .normal)
        RegisterchkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        
    }
    
    @IBAction func radioTapped(_ sender: UIButton) {
        if sender == RegisterMaleRadio{
            Gender = "M"
            RegisterMaleRadio.isSelected = true
            RegisterFemaleradio.isSelected = false
        }
        else{
            Gender = "F"
            RegisterMaleRadio.isSelected = false
            RegisterFemaleradio.isSelected = true
        }
    }
    
    @IBAction func checkbutton(_ sender: UIButton) {
        if chkbtn {
            RegisterchkBox.isSelected = true
            chkbtn = false
            chkbuttonvalue = true
            
        }else{
            RegisterchkBox.isSelected = false
            chkbtn = true
            chkbuttonvalue = false
        }
    }
    
    private func sendValidations(){
        let registerViewModel = RegisterViewModel()
        registerViewModel.registerViewModelDelegate = self
        registerViewModel.callValidations(fname: RegisterFirstname.text ?? "", lname: Registerlastname.text ?? "", email: RegisterEmail.text ?? "", pass: RegisterPassword?.text ?? "", cpass: RegisterConformPassword.text ?? "", phone: RegisterPhoneNumber?.text ?? "", btnSelected: Gender ?? "M", termsAndCondition: chkbuttonvalue ?? false)
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        sendValidations()
        }
}


extension RegisterViewController: RegisterViewModelDelegate{
    func showAlert(msg:String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        if msg == "Registered Successfull"{
            
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                let nextViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(nextViewController, animated: true)
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(action)
            
        } else {
            
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
  
