//
//  ProductViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var totalCountCell: UILabel!
    @IBOutlet weak var productTableview: UITableView!
    let viewmodel = ProductCategoryViewModel()
    var id : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableview.dataSource = self
        productTableview.delegate = self
        navigationController?.isNavigationBarHidden = false
 
        // for activating navigation bar
        navigationController?.isNavigationBarHidden = false
        
        // for removing back button title
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        
        // navigation bar back image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        
        // navigation bar back text
        navigationController?.navigationBar.backItem?.title = ""
        
        // navigation bar items color
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // addding search bitton on screen
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        
        // setting title for navigation bar
        title = "Products"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        // register cell
        productTableview.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        getdata()
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(ProductDetailsController(nibName: "ProductDetailsController", bundle: nil), animated: true)
    }
    var productDetailsData = [productList]()
    func getdata(){
        self.viewmodel.GetProductList(id: id ?? 0){
            (responce) in
            DispatchQueue.main.async {
                self.productDetailsData = responce
                self.productTableview.reloadData()
            }
            
        }
    }

    var lastVisibleIndexPath: Int = 0
    var seenCount = 0
    
}
extension ProductViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productDetailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.productTitle.text = productDetailsData[indexPath.row].name
        cell.productProducer.text = productDetailsData[indexPath.row].producer
        cell.ProductCost.text = String(productDetailsData[indexPath.row].cost)
        let ratings = getRatingStars(rating: productDetailsData[indexPath.row].ratings)
        cell.ProductRatings.text = ratings
        
        // getting image cell
        let imageurl = productDetailsData[indexPath.row].image
            self.viewmodel.imageDataProductList(stringurl: imageurl){
                (image) in
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
        
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    func getRatingStars(rating: Int) -> String {
        var stars = ""
        for _ in 0..<rating {
            stars += "⭐️" // You can use any star symbol here
        }
        return stars
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatecount()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        lastVisibleIndexPath = indexPath.row
        updatecount()
    }
    
    func updatecount()
    {
        if lastVisibleIndexPath > seenCount{
            totalCountCell.text = "\(lastVisibleIndexPath+1) / \(productDetailsData.count)"
            seenCount = lastVisibleIndexPath
        }
        
    }

    
    
}



