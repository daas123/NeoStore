//
//  ProductDetailsController.swift
//  Neostore
//
//  Created by Neosoft on 21/08/23.
//

import UIKit

class ProductDetailsController: UIViewController {
    
    @IBOutlet weak var productDetailsTableview: UITableView!
    var navigationtitle = String()
    var ProductCategory = String()
    var id = 1
    var viewmodel = ProductDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        //
        productDetailsTableview.delegate = self
        productDetailsTableview.dataSource = self
        
        let backbutton = UIBarButtonItem()
        backbutton.title = ""
        navigationItem.backBarButtonItem = backbutton
        
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
        self.navigationItem.title = navigationtitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        // register nib for tableview cell
        productDetailsTableview.register(UINib(nibName: "ProductDetailsTitleCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsTitleCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsImageCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsImageCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsDescriptionCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsBuynowCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsBuynowCell")
        productDetailsTableview.register(UINib(nibName: "SepratorCell", bundle: nil), forCellReuseIdentifier: "SepratorCell")
        // table view seprator style
        productDetailsTableview.separatorStyle = .none
        
        getdata()
    }
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
    var ProductDetials = [DetailsProduct]()
    func getdata(){
        self.viewmodel.getProductDetails(id: id ){
            (Responce) in
            DispatchQueue.main.async {
                    self.productDetailsTableview.reloadData()
                    
                }
            }
        }
    func GetCategory(id :Int) ->String{
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
    
    

    
}

extension ProductDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTitleCell", for: indexPath) as! ProductDetailsTitleCell
            titleCell.ProductTitle.text = viewmodel.GetTitle()
            titleCell.ProductProducer.text = viewmodel.GetProducer()
            titleCell.ProductCategory.text = ProductCategory
            let rating = viewmodel.GetRating() // Replace with the method to get the rating value
            titleCell.setRating(rating)
            

            return titleCell
            
        case 1:
            let detailscell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsImageCell", for: indexPath) as! ProductDetailsImageCell
            detailscell.ProductDetailsDescription.text = viewmodel.GetDescription()
            detailscell.ProductDetailsCost.text = String(viewmodel.Getcost())
            detailscell.imageCollectioViewData = viewmodel.Getimagedata()
            detailscell.reloadCollectionviewdata()
            return detailscell
        case 2:
            let buyNowCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsBuynowCell", for: indexPath) as! ProductDetailsBuynowCell
            return buyNowCell
        default:
            fatalError("Invalid section")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 2{
                return 65
            }
            return UITableView.automaticDimension // Use the default height for other cells
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        0
    }

    func getRatingStars(rating: Int) -> String {
        var stars = ""
        for i in 1...5{
            if i<=rating{
                stars += "☆"
            }else{
                stars += "☆"
            }
        }
        
        return stars
    }
}
