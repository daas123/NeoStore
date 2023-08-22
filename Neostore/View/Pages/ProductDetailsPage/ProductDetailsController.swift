//
//  ProductDetailsController.swift
//  Neostore
//
//  Created by Neosoft on 21/08/23.
//

import UIKit

class ProductDetailsController: UIViewController {
    
    @IBOutlet weak var productDetailsTableview: UITableView!
    
    
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
        self.navigationItem.title = "ProductDetails"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        // register nib for tableview cell
        productDetailsTableview.register(UINib(nibName: "ProductDetailsTitleCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsTitleCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsImageCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsImageCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsDescriptionCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsBuynowCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsBuynowCell")
        productDetailsTableview.register(UINib(nibName: "SepratorCell", bundle: nil), forCellReuseIdentifier: "SepratorCell")
        
        
        // table view seprator style
        productDetailsTableview.separatorStyle = .none
        
        
    }
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(ProductDetailsController(nibName: "ProductDetailsController", bundle: nil), animated: true)
    }
    
    
    
    
}

extension ProductDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTitleCell", for: indexPath) as! ProductDetailsTitleCell
            return productCell
        case 1,4:
            let sepratorCell = tableView.dequeueReusableCell(withIdentifier: "SepratorCell", for: indexPath) as! SepratorCell
            return sepratorCell
        case 2:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsImageCell", for: indexPath) as! ProductDetailsImageCell
            return imageCell
        case 3:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsDescriptionCell", for: indexPath) as! ProductDetailsDescriptionCell
            return descriptionCell
        case 5:
            let buyNowCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsBuynowCell", for: indexPath) as! ProductDetailsBuynowCell
            return buyNowCell
        default:
            fatalError("Invalid section")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 1 || indexPath.row == 4 { // Adjust the row index as needed
                return 13 // Set the desired height for the specific cell
            }else if indexPath.row == 5{
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

}
