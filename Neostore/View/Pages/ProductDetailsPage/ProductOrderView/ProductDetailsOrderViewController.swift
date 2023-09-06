//
//  ProductDetailsOrderViewController.swift
//  Neostore
//
//  Created by Neosoft on 31/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsOrderViewController: UIViewController {
    var deligate : RelaodProductDetailPage?
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
        productOrderLabel.text = productlabel
        if let imageUrl = URL(string: productimage ?? "invalid" ) {
            productOrderImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
            }
        orderViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        orderViewMain?.addGestureRecognizer(orderViewGesture)

        orderDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        orderDetailsview?.addGestureRecognizer(orderDetailsGesture)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @objc private func handleOrderViewTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOrderDetailsTap(_ sender: UITapGestureRecognizer) {
    }
    
    
    
    @IBAction func cancelButtonaction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        viewModel.AddToCart(productid:productId, quantity: productOrderQuantityField?.text ?? "0" ){
            (responce,Msg) in
            if responce{
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.deligate?.reloadDetailsPage()
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RatingDoneNotification"), object: nil , userInfo: ["message": Msg])
                    }
                }
            }else{
                self.showAlert(msg: Msg ?? "no data fetched")
            }
        }
    }
    
    
}
