//
//  ProductDetailsController.swift
//  Neostore
//
//  Created by Neosoft on 21/08/23.
//

import UIKit
import SDWebImage
class ProductDetailsController: BaseViewController{
    
    var navigationtitle = String()
    var ProductCategory = String()
    var Productid = Int()
    var viewmodel = ProductDetailsViewModel()
    var tapGesture: UITapGestureRecognizer!
    var productRate = ProductDetailsRateController()
    var ProductDetials = [DetailsProduct]()
    
    @IBOutlet weak var productDetailsTableview: UITableView!
    @IBOutlet weak var ProductDetailsMainView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        stopActivityIndicator()
        super.viewWillAppear(false)
        productRate.deligate = self
    }
    
    override func viewDidLoad() {
        stopActivityIndicator()
        super.viewDidLoad()
        title = navigationtitle
        getdata()
        addNotificationObserver()
        setDeligates()
        registerCell()
    }
    
    @objc override func viewWillDisappearNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            self.showAlert(msg: message)
            getdata()
        }
    }
    
    func setDeligates(){
        productDetailsTableview.delegate = self
        productDetailsTableview.dataSource = self
    }
    
    func registerCell(){
        productDetailsTableview.register(UINib(nibName: "ProductDetailsTitleCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsTitleCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsImageCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsImageCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsDescriptionCell")
        productDetailsTableview.register(UINib(nibName: "ProductDetailsBuynowCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsBuynowCell")
        productDetailsTableview.register(UINib(nibName: "SepratorCell", bundle: nil), forCellReuseIdentifier: "SepratorCell")
        // table view seprator style
        productDetailsTableview.separatorStyle = .none
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ViewWillDisappearNotification"), object: nil)
    }
    
    func getdata(){
        startActivityIndicator()
        self.viewmodel.getProductDetails(id: Productid ){
            (Responce) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
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
    
    func ShowOrderview() {
        let orderPopUpViewController = ProductDetailsOrderViewController(nibName: "ProductDetailsOrderViewController", bundle: nil)
        orderPopUpViewController.productId = self.Productid
        orderPopUpViewController.deligate = SideMenuViewController()
        orderPopUpViewController.productlabel = viewmodel.GetTitle()
        orderPopUpViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
        orderPopUpViewController.modalPresentationStyle = .overCurrentContext
        orderPopUpViewController.modalTransitionStyle = .crossDissolve
        self.present(orderPopUpViewController, animated: true, completion: nil)
    }
    
    func ShowRatingview() {
        let ratePopUpViewController = ProductDetailsRateController(nibName: "ProductDetailsRateController", bundle: nil)
        ratePopUpViewController.productlabel = viewmodel.GetTitle()
        ratePopUpViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
        ratePopUpViewController.productId = self.Productid
        ratePopUpViewController.modalPresentationStyle = .overCurrentContext
        ratePopUpViewController.modalTransitionStyle = .crossDissolve
        self.present(ratePopUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func OrderButtion(_ sender: UIButton) {
        ShowOrderview()
    }
    
    @IBAction func RateButton(_ sender: Any) {
        ShowRatingview()
    }
    
}

extension ProductDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTitleCell", for: indexPath) as! ProductDetailsTitleCell
            titleCell.productTitle.text = viewmodel.GetTitle()
            titleCell.productProducer.text = viewmodel.GetProducer()
            titleCell.productCategory.text = ProductCategory
            let rating = viewmodel.GetRating() // Replace with the method to get the rating value
            titleCell.setRating(rating)
            titleCell.selectionStyle = .none
            
            return titleCell
            
        case 1:
            let detailscell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsImageCell", for: indexPath) as! ProductDetailsImageCell
            detailscell.productDetailsDescription.text = viewmodel.GetDescription()
            detailscell.productDetailsCost.text = String(viewmodel.Getcost())
            detailscell.imageCollectioViewData = viewmodel.Getimagedata()
            detailscell.reloadCollectionviewdata()
            detailscell.selectionStyle = .none
            let imagedata = viewmodel.Getimagedata()
            if let imageUrl = URL(string: imagedata?[0].image ?? errorConstant.error) {
                detailscell.productDetailsMianImage.sd_setImage(with: imageUrl)
            }
            
            return detailscell
        default:
            fatalError(errorConstant.error)
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
}


extension ProductDetailsController : RelaodProductDetailPage{
    func reloadDetailsPage() {
        productDetailsTableview.reloadData()
    }
    func showMsg(msg:String) {
        self.showAlert(msg: msg)
    }
    
}
