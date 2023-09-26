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
        setborderRadius()
    }
    
    func setborderRadius(){
        orderDetailsview.layer.cornerRadius = 20
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
    
    static func loadFromNib()-> UIViewController{
        return ProductDetailsOrderViewController(nibName: navigationVCConstant.productDetailsOrderVC, bundle: nil)
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
    // MARK: API CALL
    @IBAction func orderButton(_ sender: UIButton) {
        startActivityIndicator()
        viewModel.AddToCart(productid:productId, quantity: productOrderQuantityField?.text ?? txtfieldValConst.emptyStr ){
            (msg) in
            if msg == txtfieldValConst.emptyStr {
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    UIView.animate(withDuration: 0.3) {
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationString.ratingDoneNotification), object: nil , userInfo: [notificationString.message: txtfieldValConst.productAddedToCart])
                        NotificationCenter.default.post(name: .reloadSideMenuData, object: nil)
                    }
                }
            }else{
                self.stopActivityIndicator()
                self.showAlert(msg: msg ?? errorConstant.error)
            }
        }
    }
}

extension ProductDetailsOrderViewController : UITextFieldDelegate{
    //MARK: For Setting On Limit On Text Fileds
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == productOrderQuantityField {
            let currentText = textField.text ?? txtfieldValConst.emptyStr
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
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
    static let reloadSideMenuData = Notification.Name(notificationString.reloadSideMenuData)
}
