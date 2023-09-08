//
//  ProductViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
import SDWebImage
class ProductViewController: UIViewController {
    @IBOutlet weak var totalCountCell: UILabel!
    @IBOutlet weak var productTableview: UITableView!
    let viewmodel = ProductCategoryViewModel()
    var id = Int()
    
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
        title = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        // register cell
        productTableview.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        // Getting the data through urlsession
        getdata()
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(ProductDetailsController(nibName: "ProductDetailsController", bundle: nil), animated: true)
    }
//    var productDetailsData = [productList]()
//
    func getdata(){
        self.startActivityIndicator()
        self.viewmodel.GetProductList(id: id ?? 0){
            (dataretrived) in
            if dataretrived{
                DispatchQueue.main.async {
                    self.productTableview.reloadData()
                    var title = self.getTitle(id: self.id ?? 0)
                    self.navigationItem.title = title
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    func getTitle(id :Int) ->String{
        switch id{
        case 1:
            return productListTile.Tables.rawValue
        case 2:
            return productListTile.Chairs.rawValue
        case 3:
            return productListTile.Sofas.rawValue
        case 4:
            return productListTile.Cupboards.rawValue
        default :
            return productListTile.error.rawValue
        }
    }
    
    // getting the data through urlsession
//    func getdata(){
//        self.viewmodel.GetProductList(id: id ?? 0){
//            (responce) in
//            DispatchQueue.main.async {
//                self.productDetailsData = responce
//                self.productTableview.reloadData()
//            }
//
//        }
//    }
    
    

    var lastVisibleIndexPath: Int = 0
    var seenCount = 0
    
}
extension ProductViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.getCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ProductDetailsController = ProductDetailsController(nibName: "ProductDetailsController", bundle: nil)
        ProductDetailsController.Productid = viewmodel.getId(row: indexPath.row)
        ProductDetailsController.ProductCategory = self.getTitle(id: self.id)
        ProductDetailsController.navigationtitle = viewmodel.getName(row: indexPath.row)
        
        self.navigationController?.pushViewController(ProductDetailsController, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.productTitle.text = viewmodel.getName(row: indexPath.row)
        cell.productProducer.text = viewmodel.getProducer(row: indexPath.row)
        cell.productCost.text = String(viewmodel.getCost(row: indexPath.row))
        let rating = viewmodel.getrating(row: indexPath.row)
        cell.setRating(rating)


       //  by using pod
        if let imageUrl = URL(string: viewmodel.getimage(row: indexPath.row)) {
                cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
            } else {
                cell.productImage.image = UIImage(named: "bg.jpg")
            }
        
        // remove the tint
        cell.selectionStyle = .none
        
        return cell
        // getting image cell using url session
//        let imageurl = productDetailsData[indexPath.row].image
//            self.viewmodel.imageDataProductList(stringurl: imageurl){
//                (image) in
//                DispatchQueue.main.async {
//                    cell.productImage.image = image
//                }
//
//        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
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
            totalCountCell.text = "\(lastVisibleIndexPath+1) / \(viewmodel.getCount())"
            seenCount = lastVisibleIndexPath
        }
        
    }

    
    
}



