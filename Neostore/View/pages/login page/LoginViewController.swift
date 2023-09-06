//
//  LoginViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var personDetailsview: [UIView]!
    
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    let viewmodel = loginViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
        for userview in personDetailsview{
            
            userview.layer.borderWidth = 1.0
            userview.layer.borderColor = UIColor.white.cgColor
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func LoginButtonAction(_ sender: UIButton) {
        viewmodel.loginValidation(email: loginUsername.text ?? "", password: loginPassword.text ?? ""){
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


