//
//  BaseViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/09/23.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: FILE CONSTANT
    var originalViewYPosition: CGFloat = 0.0
    var baseScrollView : UIScrollView?
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupkeybord()
        setupNavigationbar()
        originalViewYPosition = view.frame.origin.y
    }
    func addNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillDisappearNotification), name: NSNotification.Name(rawValue: notificationString.ratingDoneNotification ), object: nil)
    }
    
    @objc func viewWillDisappearNotification(_ notification: Notification) {
        if let message = notification.userInfo?[notificationString.message] as? String {
            self.showAlert(msg: message)
        }
    }

    func setupkeybord(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func setNavigationBarTure(){
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func setTitle(titleString:String){
        title = titleString
    }
    
    func setupNavigationbar(){
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: NavigationbarConstant.backButton_image)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = ColorConstant.primary_red
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            _ = keyboardFrame.height
            if UIResponder.currentFirstResponder is UITextField{
                UIView.animate(withDuration: 0.3) {
                    var contentInset:UIEdgeInsets = self.baseScrollView?.contentInset ?? UIEdgeInsets.zero
                    contentInset.bottom = keyboardFrame.size.height + 20
                    self.baseScrollView?.contentInset = contentInset
                }
                
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.baseScrollView?.contentInset = UIEdgeInsets.zero
        }
    }

    
}
