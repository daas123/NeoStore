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


class ProductDetailsRateController: BaseViewController {
    
    var productId = Int()
    var viewModel = RateViewModel()
    var RateGestureMain: UITapGestureRecognizer!
    var RateGestureMainSubview: UITapGestureRecognizer!
    weak var deligate : RelaodProductDetailPage?
    var productlabel : String?
    var productimage : String?
    var backrating = 0
    var currentrating = 0
    var firstselected = false
    
    
    @IBOutlet weak var rateTitle: UILabel!
    @IBOutlet var ratingImage: [UIImageView]!
    @IBOutlet weak var productDetailsMain: UIView!
    @IBOutlet weak var productDetailsSubview: UIView!
    @IBOutlet weak var productDetailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTure()
        setImage_text()
        setTapgesture()
        setRatingImage()
    }
    
    func setRatingImage(){
        for (index, image) in ratingImage.enumerated() {
            image.image = UIImage(systemName: ImageConstants.star)
            image.highlightedImage = UIImage(systemName: ImageConstants.starFill)
            image.tag = index // Set the tag to represent the index
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateButtonClickAction(_:))))
        }
    }
    
    func setImage_text(){
        if let imageUrl = URL(string: productimage ?? ImageConstants.default_img ) {
            productDetailsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ImageConstants.default_img))
        }
        rateTitle.text = productlabel
    }
    
    func setTapgesture(){
        RateGestureMain = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        productDetailsMain.addGestureRecognizer(RateGestureMain)
        
        RateGestureMainSubview = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        productDetailsSubview.addGestureRecognizer(RateGestureMainSubview)
    }
    
    static func loadFromNib()-> UIViewController{
        return ProductDetailsRateController(nibName: navigationVCConstant.productDetailsRateController, bundle: nil)
    }
    
    @objc private func handleOrderViewTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOrderDetailsTap(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func rateButtonClickAction(_ sender: UITapGestureRecognizer) {
        guard sender.view is UIImageView else {
            return
        }
        
        let selectedRating = sender.view?.tag ?? 0
        let isFirstImageSelected = ratingImage[0].isHighlighted
        if selectedRating == 0 {
            if isFirstImageSelected {
                ratingImage[0].isHighlighted = false
                for i in 0..<ratingImage.count {
                    ratingImage[i].isHighlighted = false
                }
                currentrating = 0
            } else {
                ratingImage[0].isHighlighted = true
                for i in 0..<ratingImage.count {
                    ratingImage[i].isHighlighted = i <= selectedRating
                }
                currentrating = 1
            }
        } else {
            for i in 0..<ratingImage.count {
                ratingImage[i].isHighlighted = i <= selectedRating
            }
            currentrating = selectedRating + 1
        }
//        debugPrint("User selected \(currentrating) star")
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
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationString.ratingDoneNotification), object: nil , userInfo: [notificationString.message: msg])
                        self.deligate?.reloadDetailsPage()
                    }
                }
            }
        }
    }
}
