//
//  LoginViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit
class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var navigationback: UIButton!
    @IBOutlet weak var dontHaveaccoutButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var forgetPassword: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var parentViewTapGuesture: UIView!
    
    @IBOutlet var personDetailsview: [UIView]!
    
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    
    @IBOutlet weak var passwordView: UIView!
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
        loginPassword.delegate = self
        loginUsername.delegate = self
        
        // adding the tap guesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.parentViewTapGuesture.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.parentViewTapGuesture.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginUsername:
            loginPassword.becomeFirstResponder()
        case loginPassword:
            loginPassword.resignFirstResponder() // Hide the keyboard when pressing return on the last field
        default:
            break
        }
        
        return true
    }
    
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "LOGIN"{
            self.startActivityIndicator()
            viewmodel.loginValidation(email: loginUsername.text ?? "", password: loginPassword.text ?? ""){
                (validationCheck,msgString) in
                DispatchQueue.main.async {
                    if validationCheck{
                        self.navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
                        
                        //                    self.showAlert(msg: msgString)
                    }else{
                        self.showAlert(msg: msgString)
                        self.stopActivityIndicator()
                        
                    }
                }
            }
        }else{
            self.startActivityIndicator()
            viewmodel.forgetPassword(email: loginUsername.text ?? ""){
                (responce, msg) in
                DispatchQueue.main.async {
                    if responce{
                        self.stopActivityIndicator()
                        self.showAlert(msg: "password send succesfuly")
                    }else{
                        self.stopActivityIndicator()
                        self.showAlert(msg: msg)
                    }
                }
            }
            
        }
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let vc =  RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        let attributedString = NSMutableAttributedString(string: "SEND EMAIL")
        let range = NSRange(location: 0, length: 10)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        loginButton.setAttributedTitle(attributedString, for: .normal)
        
        passwordView.isHidden = true
        forgetPassword.isHidden = true
        dontHaveaccoutButton.isHidden = true
        plusButton.isHidden = true
        navigationback.isHidden = false
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        passwordView.isHidden = false
        navigationback.isHidden = true
        forgetPassword.isHidden = false
        dontHaveaccoutButton.isHidden = false
        plusButton.isHidden = false
        let attributedString = NSMutableAttributedString(string: "LOGIN")
        let range = NSRange(location: 0, length: 5)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        loginButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    
}


