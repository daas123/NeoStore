//
//  LoginViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit
class LoginViewController: BaseViewController {
    
    // MARK: FILE CONSTANT
    let viewmodel = loginViewModel()
    var islogin = true
    
    // MARK: BACK NAVIGATION BTN
    @IBOutlet weak var navigationback: UIButton!
    
    // MARK: REGISTER BTN
    @IBOutlet weak var dontHaveaccoutButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    // MARK: FORGET PASSWORD
    @IBOutlet weak var forgetPassword: UIButton!
    
    // MARK: LOGIN BTN
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: SCROLLVIEW VIEW
    @IBOutlet weak var parentViewTapGuesture: UIView!
    
    // MARK: COLLECTION OF UIVIEW
    @IBOutlet var personDetailsview: [UIView]!
    
    // MARK: TEXT FIELD
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    // MARK: FOR PASSWORD VIEW
    @IBOutlet weak var passwordView: UIView!
    
    // MARK: ViewWillApper
    // used because when user come here after logout then in that case navigation mus tbe hidden
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        for userview in personDetailsview{
            userview.layer.borderWidth = 1.0
            userview.layer.borderColor = UIColor.white.cgColor
        }
        // MARK: Textfield Deligate
        setTexfiedDeligate()
        
        // MARK: TapGesture For ParentView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.parentViewTapGuesture.addGestureRecognizer(tapGesture)
    }
    
    func setTexfiedDeligate(){
        loginPassword.delegate = self
        loginUsername.delegate = self
    }

    static func loadFromNib()-> UIViewController{
        return LoginViewController(nibName: "LoginViewController", bundle: nil)
    }
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        if islogin {
            self.startActivityIndicator()
            viewmodel.loginValidation(email: loginUsername.text ?? "", password: loginPassword.text ?? ""){
                (validationCheck,msgString) in
                DispatchQueue.main.async {
                    if validationCheck{
                        self.navigationController?.pushViewController(HomeViewController(nibName:"HomeViewController", bundle: nil), animated: true)
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
                        self.showAlert(msg: alertMsgConstant.password_send_succesfully)
                    }else{
                        self.stopActivityIndicator()
                        self.showAlert(msg: msg)
                    }
                }
            }
            
        }
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(nibName:"RegisterViewController", bundle: nil), animated: true)
    }
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        islogin = false
        let attributedString = NSMutableAttributedString(string: btnString.sendEmail)
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
        islogin = true
        passwordView.isHidden = false
        navigationback.isHidden = true
        forgetPassword.isHidden = false
        dontHaveaccoutButton.isHidden = false
        plusButton.isHidden = false
        let attributedString = NSMutableAttributedString(string: btnString.login)
        let range = NSRange(location: 0, length: 5)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: range)
        loginButton.setAttributedTitle(attributedString, for: .normal)
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginUsername:
            loginPassword.becomeFirstResponder()
        case loginPassword:
            loginPassword.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
