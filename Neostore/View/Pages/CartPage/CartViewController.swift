//
//  CartViewController.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit

struct cartDetails{
    var name : String
    var category : String
    var image : String
}
class CartViewController: UIViewController {

    var Cartdata = [
        cartDetails(name: "Table", category: "Table", image: "table"),
        cartDetails(name: "Sofa", category: "Sofa", image: "sofa"),
        cartDetails(name: "Table", category: "Table", image: "table"),
        cartDetails(name: "Sofa", category: "Sofa", image: "sofa")
    ]
    @IBOutlet weak var CartTableview: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        
        
        self.navigationItem.title = "ProductDetails"
        //adding deligate and datasource
        CartTableview.dataSource = self
        CartTableview.dataSource = self
        
        //reg cells
        CartTableview.register(UINib(nibName: "ProductDetailsCartCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsCartCell")
        CartTableview.register(UINib(nibName: "CartTotalCell", bundle: nil), forCellReuseIdentifier: "CartTotalCell")
        CartTableview.register(UINib(nibName: "CartOrderCell", bundle: nil), forCellReuseIdentifier: "CartOrderCell")
        
    }
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
}
extension CartViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            switch indexPath.row {
            case 0,1,2:
                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell
                return productCell
            case 3:
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                return productCell
            case 4:
                let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
                return descriptionCell
            default:
                fatalError("Invalid section")
            }
        
    }
    
    
}
