//
//  HomeViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var pageControl: UIPageControl!
    //    var frame = CGFloat(0)
    let collectionViewImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    @IBOutlet weak var homeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for page controll
        pageControl.currentPage = 0
        pageControl.numberOfPages = collectionViewImages.count
        
        
        //nib register
        let reg = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(reg, forCellWithReuseIdentifier: "collectionviewcell")
        
        // collection view deligate and datasource
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        // for removing navigation
        navigationController?.isNavigationBarHidden = true
        
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollectionView.frame.width, height: homeCollectionView.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionviewcell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! HomeCollectionViewCell
        collectionviewcell.cellImage.image = UIImage(named: collectionViewImages[indexPath.row])
        return collectionviewcell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
   
}
