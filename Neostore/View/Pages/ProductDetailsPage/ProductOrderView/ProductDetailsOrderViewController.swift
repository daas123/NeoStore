//
//  ProductDetailsOrderViewController.swift
//  Neostore
//
//  Created by Neosoft on 31/08/23.
//

import UIKit

class ProductDetailsOrderViewController: UIViewController {
    
    let viewModel = OrderviewModel()
    var orderViewGesture: UITapGestureRecognizer!
    var orderDetailsGesture: UITapGestureRecognizer!
    var productId = 1    // details outlet
    
    
    
    @IBOutlet weak var ProductOrderLabel: UILabel!
    
    @IBOutlet weak var ProductOrderImage: UIImageView!
    
    @IBOutlet weak var ProductOrderQuantityField: UITextField!
    
    
    @IBOutlet weak var orderDetailsview: UIView!
    @IBOutlet weak var orderViewMain: UIView!
    var tapGesture: UITapGestureRecognizer!
    override func viewDidLoad() {
        orderViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        orderViewMain.addGestureRecognizer(orderViewGesture)

        orderDetailsGesture = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        orderDetailsview.addGestureRecognizer(orderDetailsGesture)
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
        viewModel.AddToCart(productid:productId, quantity: ProductOrderQuantityField.text ?? "0" ){
            (responce,Msg) in
            if responce{
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
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
