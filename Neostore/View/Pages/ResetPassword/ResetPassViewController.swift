//
//  ResetPassViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class ResetPassViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let viewModel = loginViewModel()
    var originalViewYPosition: CGFloat = 0.0
    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet var textFiledViews: [UIView]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        oldPassword.delegate = self
            newPassword.delegate = self
            conformPassword.delegate = self

        
        title = "Reset Password"
        for view in textFiledViews {
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        originalViewYPosition = view.frame.origin.y
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
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField,
               activeTextField != oldPassword && activeTextField != newPassword {
                UIView.animate(withDuration: 0.3) {
                    UIView.animate(withDuration: 0.3) {
                        var contentInset:UIEdgeInsets = self.scrollView.contentInset
                                contentInset.bottom = keyboardFrame.size.height + 30
                        self.scrollView.contentInset = contentInset
                    }
                }
            }
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    
    func getdata(){
        viewModel.chnagePassword(old_password:oldPassword.text ?? "", password: newPassword.text ?? "", confirm_password: conformPassword.text ?? ""){
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
