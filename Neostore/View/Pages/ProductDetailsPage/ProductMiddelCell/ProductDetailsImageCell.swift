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
        productDetailsMianImage.layer.borderColor = UIColor.red.cgColor
        productDetailsMianImage.layer.borderWidth = 2
    }
    func reloadCollectionviewdata(){
        productDeatailscollectionview.reloadData()
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
                productDetailsMianImage.sd_setImage(with: imageUrl)
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
                productDetailsMianImage.sd_setImage(with: imageUrl)
                }
    }
    
    
}
