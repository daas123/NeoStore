//
//  ProductViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
import SDWebImage
class ProductViewController: UIViewController {
    @IBOutlet weak var searchTextfiled: UITextField!
    @IBOutlet weak var totalCountCell: UILabel!
    @IBOutlet weak var productTableview: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var tableViewBottomconstrain: NSLayoutConstraint!
    var keybordheight: CGFloat = 0.0
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    var originalViewYPosition: CGFloat = 0.0
    let viewmodel = ProductCategoryViewModel()
    var id = Int()
    var productsfilteredData: [ProductListdata] = []
    var productsData: [ProductListdata] = []
    
    override func viewWillAppear(_ animated: Bool) {
        searchTextfiled.text = ""
        view.endEditing(true)
        self.tableViewBottomconstrain.constant = 0
        searchView.isHidden = true
        self.productsfilteredData = self.productsData
        productTableview.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableview.dataSource = self
        productTableview.delegate = self
        searchTextfiled.delegate = self
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
        
        // for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Getting the data through urlsession
        getdata()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.tableViewBottomconstrain.constant = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keybordheight = keyboardFrame.height
            // Check if the active text field is not FirstName or LastName
            if let activeTextField = UIResponder.currentFirstResponder as? UITextField{
                UIView.animate(withDuration: 0.3) {
                    self.tableViewBottomconstrain.constant = keybordheight
                    // Move the view upward by the keyboard's height
                    
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            // Restore the view to its original position
            self.tableViewBottomconstrain.constant = 0
            self.view.removeGestureRecognizer(self.tapGesture)
        }
    }
    
    
    @objc func searchButtonTapped() {
        if searchView.isHidden{
            searchTextfiled.text = ""
            view.endEditing(true)
            self.tableViewBottomconstrain.constant = 0
            searchView.isHidden = false
            self.productsfilteredData = self.productsData
            productTableview.reloadData()
        }else{
            searchTextfiled.text = ""
            view.endEditing(true)
            self.tableViewBottomconstrain.constant = 0
            searchView.isHidden = true
            self.productsfilteredData = self.productsData
            productTableview.reloadData()
            
        }
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        searchTextfiled.text = ""
        self.productsfilteredData = self.productsData
        productTableview.reloadData()
        view.endEditing(true)
        self.tableViewBottomconstrain.constant = 0

    }
    //
    func getdata(){
        self.startActivityIndicator()
        self.viewmodel.GetProductList(id: id ?? 0){
            (dataretrived) in
            if dataretrived{
                DispatchQueue.main.async {
                    var title = self.getTitle(id: self.id ?? 0)
                    self.navigationItem.title = title
                    self.productsData = self.viewmodel.productListDetailsData?.data ?? []
                    self.productsfilteredData = self.productsData
                    self.productTableview.reloadData()
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
        self.productsfilteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        self.startActivityIndicator()
        let ProductDetailsController = ProductDetailsController(nibName: "ProductDetailsController", bundle: nil)
        ProductDetailsController.Productid = productsfilteredData[indexPath.row].id ?? 0
        ProductDetailsController.ProductCategory = self.getTitle(id: self.id)
        ProductDetailsController.navigationtitle = productsfilteredData[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(ProductDetailsController, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.productTitle.text = productsfilteredData[indexPath.row].name
        cell.productProducer.text = productsfilteredData[indexPath.row].producer
        cell.productCost.text = String(productsfilteredData[indexPath.row].cost ?? 0)
        let rating = productsfilteredData[indexPath.row].rating ?? 0
        cell.setRating(rating)


       //  by using pod
        if let imageUrl = URL(string: productsfilteredData[indexPath.row].productImages ?? "invalid") {
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
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
extension ProductViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        productsfilteredData = productsData
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if newText.isEmpty{
            print(newText)
            productsfilteredData = productsData
        } else {
            print(newText)
            productsfilteredData = productsData.filter{$0.name?.lowercased().contains(newText.lowercased()) ?? false}
        }
        productTableview.reloadData()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        self.tableViewBottomconstrain.constant = 0
        return true
    }

    
}


