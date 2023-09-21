//
//  ProductViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
import SDWebImage
class ProductViewController: BaseViewController {
    
    // MARK: FILE VARIABLE
    var lastVisibleIndexPath: Int = 0
    var seenCount = 0
    var keybordheight: CGFloat = 0.0
    let viewmodel = ProductCategoryViewModel()
    var id = Int()
    var productsfilteredData: [ProductListdata] = []
    var productsData: [ProductListdata] = []
    
    
    @IBOutlet weak var searchTextfiled: UITextField!
    @IBOutlet weak var totalCountCell: UILabel!
    @IBOutlet weak var productTableview: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableViewBottomconstrain: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseScrollView = productTableview
        setdeligate()
        addNotificationObserver()
        addSearchButton()
        registerNib()
        getdata()
    }
    
    @objc override func viewWillDisappearNotification(_ notification: Notification) {
        getdata()
    }
    
    func addSearchButton(){
        let searchButton = UIBarButtonItem(image: UIImage(systemName: ImageConstants.magnifyingglass), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func registerNib(){
        productTableview.register(UINib(nibName: cellRegNibConstant.productTableViewCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productTableViewCell)
    }
    
    func setdeligate(){
        productTableview.dataSource = self
        productTableview.delegate = self
        searchTextfiled.delegate = self
    }
    
    func setupSearch(_ val : Bool = true){
        searchTextfiled.text = ""
        view.endEditing(true)
        self.tableViewBottomconstrain.constant = 0
        searchView.isHidden = val
        self.productsfilteredData = self.productsData
        productTableview.reloadData()
    }
    
    static func loadFromNib()-> UIViewController{
        return ProductViewController(nibName: navigationVCConstant.productListVC, bundle: nil)
    }
    
    @objc func searchButtonTapped() {
        if searchView.isHidden{
            setupSearch(false)
        }else{
            setupSearch(true)
        }
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        searchTextfiled.text = txtfieldValConst.emptyStr
        self.productsfilteredData = self.productsData
        productTableview.reloadData()
        view.endEditing(true)
        self.tableViewBottomconstrain.constant = 0
        
    }
    
    func getdata(){
        self.startActivityIndicator()
        self.viewmodel.GetProductList(id: id ){
            (dataretrived) in
            if dataretrived{
                DispatchQueue.main.async {
                    let title = self.getTitle(id: self.id )
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
    
}
extension ProductViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productsfilteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        self.startActivityIndicator()
        let ProductDetailsController = ProductDetailsController.loadFromNib() as! ProductDetailsController
        ProductDetailsController.Productid = productsfilteredData[indexPath.row].id ?? 0
        ProductDetailsController.ProductCategory = self.getTitle(id: self.id)
        ProductDetailsController.navigationtitle = productsfilteredData[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(ProductDetailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.productTableViewCell, for: indexPath) as! ProductTableViewCell
        cell.productTitle.text = productsfilteredData[indexPath.row].name
        cell.productProducer.text = productsfilteredData[indexPath.row].producer
        cell.productCost.text = String(productsfilteredData[indexPath.row].cost ?? 0)
        let rating = productsfilteredData[indexPath.row].rating ?? 0
        cell.setRating(rating)
        
        if let imageUrl = URL(string: productsfilteredData[indexPath.row].productImages ?? ImageConstants.default_img) {
            cell.productImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ImageConstants.default_img))
        } else {
            cell.productImage.image = UIImage(named: ImageConstants.default_img)
        }
        
        cell.selectionStyle = .none
        
        return cell
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
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? txtfieldValConst.emptyStr
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
        textField.resignFirstResponder()
        self.tableViewBottomconstrain.constant = 0
        return true
    }
    
}


