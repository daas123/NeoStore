//
//  ProductDetailsRateController.swift
//  Neostore
//
//  Created by Neosoft on 31/08/23.
//

import UIKit

protocol RelaodProductDetailPage:NSObject{
    func reloadDetailsPage()
    func showMsg(msg:String)
}


class ProductDetailsRateController: UIViewController {
    var productId = Int()
    var viewModel = RateViewModel()
    var RateGestureMain: UITapGestureRecognizer!
    var RateGestureMainSubview: UITapGestureRecognizer!
    weak var deligate : RelaodProductDetailPage?
    var productlabel : String?
    var productimage : String?
    // button outlet
    
    @IBOutlet var ratingButton: [UIButton]!
    
    @IBOutlet weak var productDetailsMain: UIView!
    @IBOutlet weak var productDetailsSubview: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        RateGestureMain = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        productDetailsMain.addGestureRecognizer(RateGestureMain)

        RateGestureMainSubview = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        productDetailsSubview.addGestureRecognizer(RateGestureMainSubview)
        
        for buttonicon in ratingButton{
            buttonicon.setImage(UIImage(systemName: "star"), for: .normal)
            buttonicon.setImage(UIImage(systemName: "star.fill"), for: .selected)
        }
        
        
    }
    
    @objc private func handleOrderViewTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOrderDetailsTap(_ sender: UITapGestureRecognizer) {
    }

    var backrating = 0
    var currentrating = 0
    @IBAction func rateButtonClickAction(_ sender: UIButton) {
        if sender.tag >= backrating{
            for rate in 0...sender.tag{
                ratingButton[rate].isSelected = true
            }
            backrating = sender.tag
            currentrating = sender.tag + 1
        }else{
            
            currentrating = sender.tag
            backrating = sender.tag
            for rate in backrating...4{
                ratingButton[rate].isSelected = false
            }
        }
        print("user seleccted \(sender.tag) and my count \(backrating) and rating is \(currentrating) ")
    }
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RateButtonAction(_ sender: UIButton) {
        viewModel.sendRating(rating: currentrating, productId: productId){
            (responce,msg) in
            print(self.currentrating)
            if responce {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RatingDoneNotification"), object: nil , userInfo: ["message": msg])
                        
                            self.deligate?.reloadDetailsPage()
                    }
                }
            }
        }
    }
    
}
