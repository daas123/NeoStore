//
//  ProductDetailsController.swift
//  Neostore
//
//  Created by Neosoft on 21/08/23.
//

import UIKit

class ProductDetailsController: UIViewController {
    
    @IBOutlet weak var productDetailsTableview: UITableView!
    @IBOutlet weak var ProductDetailsMainView: UIView!
    var navigationtitle = String()
    var ProductCategory = String()
    var Productid = Int()
    var viewmodel = ProductDetailsViewModel()
    var tapGesture: UITapGestureRecognizer!
    var productRate = ProductDetailsRateController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        productRate.deligate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        productRate.deligate = self
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillDisappearNotification), name: NSNotification.Name(rawValue: "RatingDoneNotification"), object: nil)
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
        
        // getdatresponce from view model
        getdata()
        
        //adding tap guestiure
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
    }
    
    @objc private func viewWillDisappearNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            self.showAlert(msg: message)
            getdata()
        }
    }
    
    deinit {
            // Remove the observer when the view is deallocated
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ViewWillDisappearNotification"), object: nil)
        }
    // view didload end
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        print("tap occured")
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(CartViewController(nibName: "CartViewController", bundle: nil), animated: true)
    }
    var ProductDetials = [DetailsProduct]()
    func getdata(){
        self.viewmodel.getProductDetails(id: Productid ){
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
    
    func ShowOrderview() {
            let popupViewController = ProductDetailsOrderViewController(nibName: "ProductDetailsOrderViewController", bundle: nil)
            popupViewController.productId = self.Productid
            popupViewController.productlabel = viewmodel.GetTitle()
            popupViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
            popupViewController.modalPresentationStyle = .overCurrentContext
            popupViewController.modalTransitionStyle = .crossDissolve
            self.present(popupViewController, animated: true, completion: nil)
    }
    
    func ShowRatingview() {
            let popupViewController = ProductDetailsRateController(nibName: "ProductDetailsRateController", bundle: nil)
            popupViewController.productlabel = viewmodel.GetTitle()
            popupViewController.productimage = viewmodel.productDetailsData?.data?.product_images?.first?.image
            popupViewController.productId = self.Productid
            popupViewController.modalPresentationStyle = .overCurrentContext
            popupViewController.modalTransitionStyle = .crossDissolve
            self.present(popupViewController, animated: true, completion: nil)
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
            

            return titleCell
            
        case 1:
            let detailscell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsImageCell", for: indexPath) as! ProductDetailsImageCell
            detailscell.productDetailsDescription.text = viewmodel.GetDescription()
            detailscell.productDetailsCost.text = String(viewmodel.Getcost())
            detailscell.imageCollectioViewData = viewmodel.Getimagedata()
            detailscell.reloadCollectionviewdata()
            return detailscell
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
}


extension ProductDetailsController : RelaodProductDetailPage{
    func reloadDetailsPage() {
        productDetailsTableview.reloadData()
    }
    func showMsg(msg:String) {
        self.showAlert(msg: msg)
    }
    
}
