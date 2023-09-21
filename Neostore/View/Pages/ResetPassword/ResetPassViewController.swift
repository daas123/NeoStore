//
//  ResetPassViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class ResetPassViewController: BaseViewController, UITextFieldDelegate {
    
    let viewModel = loginViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet var textFiledViews: [UIView]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setTitle(titleString: pageTitleConstant.reset_Password)
        for view in textFiledViews {
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        }
       
    }
    func setupTapGuesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupdeligate(){
        oldPassword.delegate = self
        newPassword.delegate = self
        conformPassword.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case oldPassword:
            newPassword.becomeFirstResponder()
        case newPassword:
            conformPassword.becomeFirstResponder()
        case conformPassword:
            conformPassword.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func getdata(){
        startActivityIndicator()
        viewModel.chnagePassword(old_password:oldPassword.text ?? "", password: newPassword.text ?? "", confirm_password: conformPassword.text ?? ""){
            (responce,msg) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
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
