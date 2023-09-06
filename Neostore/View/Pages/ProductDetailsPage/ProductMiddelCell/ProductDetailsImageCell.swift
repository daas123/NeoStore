//
//  ProductDetailsImageCell.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsImageCell: UITableViewCell {
    //cost
    @IBOutlet weak var ProductDetailsCost: UILabel!
    // text
    @IBOutlet weak var ProductDetailsDescription: UILabel!
   //image
    @IBOutlet weak var ProductDetailsMianImage: UIImageView!
    // container outlet
    @IBOutlet weak var ProductDetailsImageContainerView: UIView!
   // collectionview cell
    @IBOutlet weak var ProductDeatailscollectionview: UICollectionView!
    // get CollectionviewData
    var imageCollectioViewData : [Product_images]?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        ProductDeatailscollectionview.delegate = self
        ProductDeatailscollectionview.dataSource = self
        ProductDeatailscollectionview.register(UINib(nibName: "ImageCollectionviewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsImagecell")
        ProductDetailsImageContainerView.layer.cornerRadius = 10
        ProductDetailsMianImage.layer.borderColor = UIColor.red.cgColor
        ProductDetailsMianImage.layer.borderWidth = 2
    }
    func reloadCollectionviewdata(){
        ProductDeatailscollectionview.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func ProductDetailsShareButton(_ sender: UIButton) {
    }
    
    
}

extension ProductDetailsImageCell : UICollectionViewDelegate ,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollectioViewData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Imagecell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsImagecell", for: indexPath) as! ImageCollectionviewCell
        if let imageUrl = URL(string: imageCollectioViewData?[indexPath.row].image ?? "invalid") {
            if indexPath.row == 0{
                ProductDetailsMianImage.sd_setImage(with: imageUrl)
            }
            Imagecell.productDetailsImagecell.sd_setImage(with: imageUrl)
            }
        return Imagecell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height:100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let imageUrl = URL(string: imageCollectioViewData?[indexPath.row].image ?? "invalid") {
                ProductDetailsMianImage.sd_setImage(with: imageUrl)
                }
    }
    
    
}
