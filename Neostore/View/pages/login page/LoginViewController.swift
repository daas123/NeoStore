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
            userview.layer.borderColor = UIColor.white.cgColor
            userview.layer.cornerRadius = 1.0
            
        }
        // Do any additional setup after loading the view.
    }

}
