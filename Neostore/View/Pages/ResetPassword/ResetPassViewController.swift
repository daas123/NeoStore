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
    static func loadFromNib()-> UIViewController{
        return ResetPassViewController(nibName: navigationVCConstant.reSetPassVC, bundle: nil)
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
        self.startActivityIndicator()
        viewModel.chnagePassword(old_password:oldPassword.text ?? txtfieldValConst.emptyStr, password: newPassword.text ?? txtfieldValConst.emptyStr, confirm_password: conformPassword.text ?? txtfieldValConst.emptyStr){
            (responce,msg) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if responce {
                    self.showAlert(msg: msg)
                    self.oldPassword.text = txtfieldValConst.emptyStr
                    self.newPassword.text = txtfieldValConst.emptyStr
                    self.conformPassword.text = txtfieldValConst.emptyStr
                    self.navigationController?.pushViewController(HomeViewController.loadFromNib(), animated: true)
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
