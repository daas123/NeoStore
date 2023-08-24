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

    private func sendValidations(){
        let loginViewModel = loginViewModel()
        loginViewModel.logindeligate = self
        loginViewModel.callValidations(username: LoginUsername.text ?? "" , password: LoginPassword.text ?? "")
        
    }
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        sendValidations()
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let vc =  RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: loginviewDeligate{
    func showAlert(msg:String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        if msg == "login Successfull"{
            
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                let nextViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
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
  
