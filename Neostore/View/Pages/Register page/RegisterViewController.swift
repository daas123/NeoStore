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
       
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        for registerViews in registerDetailsView{
            registerViews.layer.borderWidth = 1
            registerViews.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
    }
    
    

}
