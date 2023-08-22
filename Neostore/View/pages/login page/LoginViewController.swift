//
//  LoginViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var personDetailsview: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for userview in personDetailsview{
            
            userview.layer.borderWidth = 1.0
            userview.layer.borderColor = UIColor.white.cgColor
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        let vc =  RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let vc =  RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)

        
    }
    

}
