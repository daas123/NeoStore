//
//  ProductDetailsOrderViewController.swift
//  Neostore
//
//  Created by Neosoft on 31/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsOrderViewController: UIViewController {
    
    var originalViewYPosition: CGFloat = 0.0
    var deligate : ReloadSideMenuData?
    let viewModel = OrderviewModel()
    var orderViewGesture: UITapGestureRecognizer!
    var orderDetailsGesture: UITapGestureRecognizer!
    var productId = Int()      // details outlet
    
    var productlabel : String?
    var productimage : String?
    @IBOutlet weak var productOrderLabel: UILabel!
    
    @IBOutlet weak var productOrderImage: UIImageView!
    
    @IBOutlet weak var productOrderQuantityField: UITextField!
    
    
    @IBOutlet weak var orderDetailsview: UIView!
    @IBOutlet weak var orderViewMain: UIView!
    var tapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        productOrderQuantityField.becomeFirstResponder()
        productOrderLabel.text = productlabel
        if let imageUrl = URL(string: productimage ?? "invalid" ) {
            productOrderImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
            }
        
        orderViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        orderViewMain?.addGestureRecognizer(orderViewGesture)

        orderDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        orderDetailsview?.addGestureRecognizer(orderDetailsGesture)
        super.viewDidLoad()
        
        
        // for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        originalViewYPosition = view.frame.origin.y
        
        
        
        // Do any additional setup after loading the view.
        //text filed deligate
        productOrderQuantityField.delegate = self
        
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Check if the active text field is not FirstName or LastName
            if UIResponder.currentFirstResponder is UITextField {
                UIView.animate(withDuration: 0.3) {
                    // Move the view upward by the keyboard's height
                    self.view.frame.origin.y = self.originalViewYPosition - keyboardHeight + 200
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.view.frame.origin.y = self.originalViewYPosition
        }
    }
    
    @objc private func handleOrderViewTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOrderDetailsTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    @IBAction func cancelButtonaction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        startActivityIndicator()
        viewModel.AddToCart(productid:productId, quantity: productOrderQuantityField?.text ?? "0" ){
            (responce,Msg) in
            if responce{
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
//                        self.deligate?.reloadSidemenu()
                        NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RatingDoneNotification"), object: nil , userInfo: ["message": Msg])
                        self.stopActivityIndicator()
                    }
                }
            }else{
                self.showAlert(msg: Msg ?? "no data fetched")
            }
        }
    }
    
    
}


extension ProductDetailsOrderViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Check if the text field is the digitTextField
           if textField == productOrderQuantityField {
               // Get the current text in the text field
               let currentText = textField.text ?? ""
               
               // Combine the current text with the replacement text
               let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
               
               // Check if the updated text has more than 2 characters
               if updatedText.count <= 1 {
                   return true
               } else {
                   return false
               }
           }
           
           return true
       }

}
extension Notification.Name {
    static let reloadSideMenuData = Notification.Name("ReloadSideMenuData")
}
