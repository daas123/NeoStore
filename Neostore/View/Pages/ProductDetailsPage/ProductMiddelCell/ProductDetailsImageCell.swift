//
//  ProductDetailsImageCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsImageCell: UITableViewCell {
    var selectedImageIndex = 0
    //cost
    @IBOutlet weak var productDetailsCost: UILabel!
    // text
    @IBOutlet weak var productDetailsDescription: UILabel!
    //image
    @IBOutlet weak var productDetailsMianImage: UIImageView!
    // container outlet
    @IBOutlet weak var productDetailsImageContainerView: UIView!
    // collectionview cell
    @IBOutlet weak var productDeatailscollectionview: UICollectionView!
    // get CollectionviewData
    var imageCollectioViewData : [Product_images]?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        productDeatailscollectionview.delegate = self
        productDeatailscollectionview.dataSource = self
        productDeatailscollectionview.register(UINib(nibName: "ImageCollectionviewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsImagecell")
        productDetailsImageContainerView.layer.cornerRadius = 10
        productDetailsMianImage.layer.borderColor = UIColor.gray.cgColor
        productDetailsMianImage.layer.borderWidth = 1
        
        
        //for keyboard
        
    }
    
    
    func reloadCollectionviewdata(){
        productDeatailscollectionview.reloadData()
    }
    
    @IBAction func ProductDetailsShareButton(_ sender: UIButton) {
        shareProductDetails()
    }
    func shareProductDetails() {
        if let image = productDetailsMianImage.image,
           let productName = productDetailsDescription.text,
           let productPrice = productDetailsCost.text {
            
            let shareItems: [Any] = [image, "\(productName)\nPrice: \(productPrice)"]
            
            let activityViewController = UIActivityViewController(
                activityItems: shareItems,
                applicationActivities: nil
            )
            
            if let viewController = self.parentViewController {
                viewController.present(activityViewController, animated: true, completion: nil)
            }
            
        }
    }

    
    
    
}

extension ProductDetailsImageCell : UICollectionViewDelegate ,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollectioViewData?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsImagecell", for: indexPath) as! ImageCollectionviewCell
        
        if indexPath.row == selectedImageIndex {
            imageCell.setBorder()
        } else {
            imageCell.clearBorder()
        }
        
        if let imageUrl = URL(string: imageCollectioViewData?[indexPath.row].image ?? "invalid") {
            imageCell.productDetailsImagecell.sd_setImage(with: imageUrl)
        }
        
        return imageCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height:100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedImageIndex = indexPath.row
        collectionView.reloadData()
        
        let itemIndexPath = IndexPath(item: selectedImageIndex, section: 0)
           collectionView.scrollToItem(at: itemIndexPath, at: .centeredHorizontally, animated: true)
        
        if let imageUrl = URL(string: imageCollectioViewData?[indexPath.row].image ?? "invalid") {
            productDetailsMianImage.sd_setImage(with: imageUrl)
        }
    }
    
    
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
