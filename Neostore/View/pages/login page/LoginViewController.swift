//
//  LoginViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var personDetailsview: [UIView]!
    
    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    let viewmodel = loginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for userview in personDetailsview{
            
            userview.layer.borderWidth = 1.0
            userview.layer.borderColor = UIColor.white.cgColor
            
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func LoginButtonAction(_ sender: UIButton) {
        viewmodel.loginValidation(email: LoginUsername.text ?? "", password: LoginPassword.text ?? ""){
            (validationCheck,msgString) in
            DispatchQueue.main.async {
                if validationCheck{
                    self.navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
//                    self.showAlert(msg: msgString)
                }else{
                    self.showAlert(msg: msgString)
                }
            }
        }
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let vc =  RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}


