//
//  ProductViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
struct productDetails{
    var name:String
    var producer:String
    var cost:Int
    var ratings:Int
}
class ProductViewController: UIViewController {
    @IBOutlet weak var totalCountCell: UILabel!
    @IBOutlet weak var productTableview: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        productTableview.dataSource = self
        productTableview.delegate = self
        
        // for activating navigation bar
        navigationController?.isNavigationBarHidden = false
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
        // setting color for navigation bar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // register cell
        productTableview.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(HomeViewController(nibName: "HomeViewController", bundle: nil), animated: true)
    }
    
    let productDetailsData = [
        productDetails(name: "Table", producer: "helogen", cost: 2000,ratings: 2),
        productDetails(name: "sofa", producer: "nitrogen", cost: 3000, ratings: 3),
        productDetails(name: "sofa", producer: "nitrogen", cost: 5000, ratings: 4),
        productDetails(name: "hotel", producer: "melting", cost: 9000, ratings: 5),
        productDetails(name: "dosa", producer: "point", cost: 5000, ratings: 1),
        productDetails(name: "Table", producer: "helogen", cost: 2000,ratings: 2),
        productDetails(name: "sofa", producer: "nitrogen", cost: 3000, ratings: 3),
        productDetails(name: "sofa", producer: "nitrogen", cost: 5000, ratings: 4),
        productDetails(name: "hotel", producer: "melting", cost: 9000, ratings: 5),
        productDetails(name: "dosa", producer: "point", cost: 5000, ratings: 1)
    ]
    
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
