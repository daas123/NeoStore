//
//  RegisterViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet var registerDetailsView: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for registerViews in registerDetailsView{
            registerViews.layer.borderWidth = 1
            registerViews.layer.borderColor = UIColor.white.cgColor
        }
    }


    

}
