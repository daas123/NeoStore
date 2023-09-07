//
//  MyAccountViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyAccountViewController: UIViewController {

    let viewModel = SideMenuViewmodel()
    @IBOutlet var myAccountTextViews: [UIView]!
    
    
    @IBOutlet weak var accountFname: UITextField!
    @IBOutlet weak var accountLname: UITextField!
    @IBOutlet weak var accountEmail: UITextField!
    @IBOutlet weak var accountPhoneNo: UITextField!
    @IBOutlet weak var accountDateOfBirth: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for textViews in myAccountTextViews{
            textViews.layer.borderWidth = 1
            textViews.layer.borderColor = UIColor.white.cgColor
        }
        
        navigationController?.isNavigationBarHidden = false
        // for activating navigation bar
        
        // for removing back button title
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
        // navigation bar back image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        // setting title for navigation bar
        title = "AccountDetails"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // Do any additional setup after loading the view.
        getData()
    }
    
    func assignDatatoTextfields(){
        
    }
    func getData(){
        viewModel.fetchAccountDetails(){
            responce in
            if responce {
                
            }
        }
    }
    
    
    @IBAction func EditProfileAction(_ sender: UIButton) {
        
    }
    
    @IBAction func ResetPasswordAction(_ sender: UIButton) {
        
    }
    



}
