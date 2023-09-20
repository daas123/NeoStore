//
//  ProductDetailsOrderViewController.swift
//  Neostore
//
//  Created by Neosoft on 31/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsOrderViewController: BaseViewController {
    // MARK: FILE VARIABLE
    var deligate : ReloadSideMenuData?
    let viewModel = OrderviewModel()
    var orderViewGesture: UITapGestureRecognizer!
    var orderDetailsGesture: UITapGestureRecognizer!
    var productId = Int()
    var productlabel : String?
    var productimage : String?
    var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var productOrderLabel: UILabel!
    @IBOutlet weak var productOrderImage: UIImageView!
    @IBOutlet weak var productOrderQuantityField: UITextField!
    @IBOutlet weak var orderDetailsview: UIView!
    @IBOutlet weak var orderViewMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTure()
        productOrderQuantityField.becomeFirstResponder()
        setDeligate()
        setimage_titile()
        setTapGesture()
    }
    
    func setDeligate(){
        productOrderQuantityField.delegate = self
    }
    
    func setimage_titile(){
        productOrderLabel.text = productlabel
        if let imageUrl = URL(string: productimage ?? ImageConstants.default_img ) {
            productOrderImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ImageConstants.default_img))
        }
    }
    
    func setTapGesture(){
        //MARK: Hide OnClick Of External Screen
        orderViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        orderViewMain?.addGestureRecognizer(orderViewGesture)
        
        //MARK: Hide OnClick Of Product Details
        orderDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        orderDetailsview?.addGestureRecognizer(orderDetailsGesture)
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
                    self.stopActivityIndicator()
                    UIView.animate(withDuration: 0.3) {
                        NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }else{
                self.stopActivityIndicator()
                self.showAlert(msg: Msg ?? errorConstant.error)
            }
        }
    }
}

extension ProductDetailsOrderViewController : UITextFieldDelegate{
    //MARK: For Setting On Limit On Text Fileds
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
