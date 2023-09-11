//
//  ResetPassViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class ResetPassViewController: UIViewController {
    
    let viewModel = loginViewModel()
    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet var textFiledViews: [UIView]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Reset Password"
        for view in textFiledViews {
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        }
    }
    
    func getdata(){
        viewModel.forgetPassword(old_password:oldPassword.text ?? "", password: newPassword.text ?? "", confirm_password: conformPassword.text ?? ""){
            (responce,msg) in
            DispatchQueue.main.async {
                if responce {
                    self.showAlert(msg: msg)
                    self.oldPassword.text = ""
                    self.newPassword.text = ""
                    self.conformPassword.text = ""
                    self.navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
                }else{
                    self.showAlert(msg: msg)
                }
            }
            
        }
    }
    
    @IBAction func submitacton(_ sender: UIButton) {
        getdata()
    }
    
}
