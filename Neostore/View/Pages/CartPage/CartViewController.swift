//
//  CartViewController.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import UIKit
import SDWebImage
struct cartDetails{
    var name : String
    var category : String
    var image : String
}
class CartViewController: UIViewController {

    let viewModel = CartViewModel()
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
        
        //getData
        getData()
    }
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
    
    func getData(){
        viewModel.getCartDetails(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.CartTableview.reloadData()
                }
            }
        }
    }
    
    
    
}
extension CartViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2+(viewModel.cartData?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let totalData = viewModel.cartData?.count{
            switch indexPath.row{
            case 0...totalData-1:
                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell
                productCell.CartProductName.text = viewModel.cartData?.data[indexPath.row].product?.name
                productCell.cartProductCategory.text = viewModel.cartData?.data[indexPath.row].product?.productCategory
                productCell.CartProductQuantity.text = String( viewModel.cartData?.data[indexPath.row].quantity ?? 0)
                productCell.CartProuductTotalCost.text = String(viewModel.cartData?.data[indexPath.row].product?.cost ?? 0)
                if let imageUrl = URL(string: viewModel.cartData?.data[indexPath.row].product?.productImages ?? "invalid" ) {
                    productCell.CartProductImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
                    } else {
                        productCell.CartProductImage.image = UIImage(named: "bg.jpg")
                    }
                
                return productCell
            case totalData:
                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
                return productCell
            case totalData + 1:
                let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
                return descriptionCell
            default :
                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell
                return productCell
            }
        }else{
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
            return descriptionCell
        }
//            switch indexPath.row {
//            case 0...((viewModel.cartData?.count ?? 0)-1):
//                let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsCartCell", for: indexPath) as! ProductDetailsCartCell
//                return productCell
//            case totalcount - 1:
//                let productCell = tableView.dequeueReusableCell(withIdentifier: "CartTotalCell", for: indexPath) as! CartTotalCell
//                return productCell
//            case totalcount:
//                let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "CartOrderCell", for: indexPath) as! CartOrderCell
//                return descriptionCell
//            default:
//                fatalError("Invalid section")
//            }
        
    }
    
    
}
