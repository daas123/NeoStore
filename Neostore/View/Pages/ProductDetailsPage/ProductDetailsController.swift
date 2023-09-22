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
        if let message = notification.userInfo?[notificationString.message] as? String {
            self.showAlert(msg: message)
            getdata()
        }
    }
    
    func setDeligates(){
        productDetailsTableview.delegate = self
        productDetailsTableview.dataSource = self
    }
    
    func registerCell(){
        productDetailsTableview.register(UINib(nibName: cellRegNibConstant.productDetailsTitleCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productDetailsTitleCell)
        productDetailsTableview.register(UINib(nibName: cellRegNibConstant.productDetailsImageCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productDetailsImageCell)
        productDetailsTableview.register(UINib(nibName: cellRegNibConstant.productDetailsDescriptionCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productDetailsDescriptionCell)
        productDetailsTableview.register(UINib(nibName: cellRegNibConstant.productDetailsBuynowCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.productDetailsBuynowCell)
        productDetailsTableview.register(UINib(nibName: cellRegNibConstant.sepratorCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.sepratorCell)
        // table view seprator style
        productDetailsTableview.separatorStyle = .none
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: notificationString.viewWillDisappearNotification), object: nil)
    }
    
    func getdata(){
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
        let orderPopUpViewController = ProductDetailsOrderViewController.loadFromNib() as! ProductDetailsOrderViewController
        orderPopUpViewController.productId = self.Productid
        orderPopUpViewController.deligate = SideMenuViewController()
        orderPopUpViewController.productlabel = viewmodel.GetTitle()
        orderPopUpViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
        orderPopUpViewController.modalPresentationStyle = .overCurrentContext
        orderPopUpViewController.modalTransitionStyle = .crossDissolve
        self.present(orderPopUpViewController, animated: true, completion: nil)
    }
    
    func ShowRatingview() {
        let ratePopUpViewController = ProductDetailsRateController.loadFromNib() as! ProductDetailsRateController
        ratePopUpViewController.productlabel = viewmodel.GetTitle()
        ratePopUpViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
        ratePopUpViewController.productId = self.Productid
        ratePopUpViewController.modalPresentationStyle = .overCurrentContext
        ratePopUpViewController.modalTransitionStyle = .crossDissolve
        self.present(ratePopUpViewController, animated: true, completion: nil)
    }
    
    static func loadFromNib()-> UIViewController{
        return ProductDetailsController(nibName: navigationVCConstant.productDetailsVC, bundle: nil)
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
            let titleCell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.productDetailsTitleCell, for: indexPath) as! ProductDetailsTitleCell
            titleCell.productTitle.text = viewmodel.GetTitle()
            titleCell.productProducer.text = viewmodel.GetProducer()
            titleCell.productCategory.text = ProductCategory
            let rating = viewmodel.GetRating() // Replace with the method to get the rating value
            titleCell.setRating(rating)
            titleCell.selectionStyle = .none
            
            return titleCell
            
        case 1:
            let detailscell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.productDetailsImageCell, for: indexPath) as! ProductDetailsImageCell
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
