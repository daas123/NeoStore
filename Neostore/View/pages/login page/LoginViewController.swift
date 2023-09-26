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
    let leftImageView = UIImageView()
    
    // MARK: IBOUTLET
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
 
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUsername.setIcon(UIImage(systemName: ImageConstants.person )!)
        loginPassword.setIcon(UIImage(systemName: ImageConstants.lock )!)
        
        loginUsername.setBorder()
        loginPassword.setBorder()

        // MARK: Textfield Deligate
        setTexfiedDeligate()
        
        // MARK: TapGesture For ParentView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.parentViewTapGuesture.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setTexfiedDeligate(){
        loginPassword.delegate = self
        loginUsername.delegate = self
    }

    static func loadFromNib()-> UIViewController{
        return LoginViewController(nibName: navigationVCConstant.loginVC, bundle: nil)
    }
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        startActivityIndicator()
        if islogin {
            //MARK: API CALL FOR LOGIN
            viewmodel.loginValidation(email: loginUsername.text ?? txtfieldValConst.emptyStr, password: loginPassword.text ?? txtfieldValConst.emptyStr){
                (msgString) in
                DispatchQueue.main.async {
                    if msgString == txtfieldValConst.emptyStr {
                        self.navigationController?.pushViewController(HomeViewController.loadFromNib(), animated: true)
                    }else{
                        self.showAlert(msg: msgString)
                    }
                    self.stopActivityIndicator()
                }
            }
        }else{
            //MARK: API CALL FOR FORGOT
            viewmodel.forgetPassword(email: loginUsername.text ?? txtfieldValConst.emptyStr){
                (msg) in
                DispatchQueue.main.async {
                    if msg == txtfieldValConst.emptyStr {
                        self.showAlert(msg: alertMsgConstant.password_send_succesfully)
                    }else{
                        self.showAlert(msg: msg)
                    }
                    self.stopActivityIndicator()
                }
            }
            
        }
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController.loadFromNib(), animated: true)
    }
    
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        islogin = false
        loginUsername.text = txtfieldValConst.emptyStr
        loginPassword.text = txtfieldValConst.emptyStr
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
        loginUsername.text = txtfieldValConst.emptyStr
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
