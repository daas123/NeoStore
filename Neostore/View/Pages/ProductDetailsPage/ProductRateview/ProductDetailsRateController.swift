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
    
    
    @IBOutlet var ratingImage: [UIImageView]!
    
    @IBOutlet weak var productDetailsMain: UIView!
    @IBOutlet weak var productDetailsSubview: UIView!
    @IBOutlet weak var productDetailsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: productimage ?? "invalid" ) {
            productDetailsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
            }
        RateGestureMain = UITapGestureRecognizer(target: self, action: #selector(handleOrderViewTap(_:)))
        productDetailsMain.addGestureRecognizer(RateGestureMain)

        RateGestureMainSubview = UITapGestureRecognizer(target: self, action: #selector(handleOrderDetailsTap(_:)))
        productDetailsSubview.addGestureRecognizer(RateGestureMainSubview)
        
        for (index, image) in ratingImage.enumerated() {
            image.image = UIImage(systemName: "star")
            image.highlightedImage = UIImage(systemName: "star.fill")
            image.tag = index // Set the tag to represent the index
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateButtonClickAction(_:))))
        }
        
    }
    
    @objc private func handleOrderViewTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOrderDetailsTap(_ sender: UITapGestureRecognizer) {
    }

    var backrating = 0
    var currentrating = 0
    var firstselected = false
    @IBAction func rateButtonClickAction(_ sender: UITapGestureRecognizer) {
        guard sender.view is UIImageView else {
            return
        }
        
        let selectedRating = sender.view?.tag ?? 0
        
        // Check if the first image is already selected
        let isFirstImageSelected = ratingImage[0].isHighlighted
        if selectedRating == 0 {
            // If the first image is already selected, unselect it
            if isFirstImageSelected {
                ratingImage[0].isHighlighted = false
                currentrating = 0
            } else {
                // If the first image is not selected, select it
                ratingImage[0].isHighlighted = true
                currentrating = 1
            }
        } else {
            // Handle the selection of other stars
            for i in 0..<ratingImage.count {
                ratingImage[i].isHighlighted = i <= selectedRating
            }
            currentrating = selectedRating + 1
        }
        
        debugPrint("User selected \(currentrating) star")
    }




    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RateButtonAction(_ sender: UIButton) {
        self.startActivityIndicator()
        viewModel.sendRating(rating: currentrating, productId: productId){
            (responce,msg) in
            print(self.currentrating)
            if responce {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self.dismiss(animated: true, completion: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RatingDoneNotification"), object: nil , userInfo: ["message": msg])
                            self.deligate?.reloadDetailsPage()
                        self.stopActivityIndicator()
                    }
                }
            }
        }
    }
    
}
