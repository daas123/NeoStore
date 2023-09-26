//
//  SideMenuViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
import NVActivityIndicatorView
class SideMenuViewController: UIViewController {
    
    // MARK: FILE VARIABLE
    var viewmodel = SideMenuViewmodel()
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var sideMenuImage: UIImageView!
    @IBOutlet weak var sideMenuTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reloadSideMenuData, object: nil)
        setupTapguesture()
        setupDeligate()
        setupSideMenuImage()
        registerNib()
        getData()
    }
    
    func setupTapguesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profileview.addGestureRecognizer(tapGesture)
    }
    
    func setupDeligate(){
        sideMenuTableview.delegate = self
        sideMenuTableview.dataSource = self
    }
    
    func registerNib(){
        let reg = UINib(nibName: cellRegNibConstant.sideMenuTableViewCell, bundle: nil)
        sideMenuTableview.register(reg, forCellReuseIdentifier: cellRegNibConstant.sideMenuTableViewCell)
        let cart = UINib(nibName: cellRegNibConstant.cartTableViewCell, bundle: nil)
        sideMenuTableview.register(cart, forCellReuseIdentifier: cellRegNibConstant.cartTableViewCell)
    }
    
    func setupSideMenuImage(){
        sideMenuImage.image = UIImage(named: ImageConstants.default_img)
        sideMenuImage.layer.cornerRadius = sideMenuImage.frame.size.width / 2
        sideMenuImage.clipsToBounds = true
    }
    
    func reloadProfileImage(){
        if let accessToken = SideMenuViewmodel.menuDemoData.data?.user_data?.access_token,
           let imageData = UserDefaults.standard.data(forKey: accessToken),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.sideMenuImage.image = image
            }
        }else{
            DispatchQueue.main.async {
                self.sideMenuImage.image = UIImage(named: ImageConstants.default_img)
            }
        }
    }
    
    static func loadFromNib()-> UIViewController{
        return SideMenuViewController(nibName: navigationVCConstant.sideMenuVC, bundle: nil)
    }
    
    @objc func handleTap() {
        let MyAccountViewController = MyAccountViewController.loadFromNib() as! MyAccountViewController
        MyAccountViewController.accesstoken = SideMenuViewmodel.menuDemoData.data?.user_data?.access_token
        navigationController?.pushViewController(MyAccountViewController, animated: true)
    }
    
    @objc func reloadData() {
        viewmodel.fetchAccountDetails{_ in
            DispatchQueue.main.async {
                self.sideMenuTableview.reloadData()
                self.reloadProfileImage()
                self.userEmail.text = SideMenuViewmodel.menuDemoData.data?.user_data?.email
                self.userName.text = (SideMenuViewmodel.menuDemoData.data?.user_data?.first_name ?? txtfieldValConst.emptyStr) + (SideMenuViewmodel.menuDemoData.data?.user_data?.last_name ?? txtfieldValConst.emptyStr)
            }
        }
    }
    
    // MARK: API CALL
    func getData(){
        startActivityIndicator()
        viewmodel.fetchAccountDetails{
            respose in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                if respose{
                    self.stopActivityIndicator()
                    self.sideMenuTableview.reloadData()
                    self.userEmail.text = SideMenuViewmodel.menuDemoData.data?.user_data?.email
                    self.userName.text = (SideMenuViewmodel.menuDemoData.data?.user_data?.first_name ?? txtfieldValConst.emptyStr) + (SideMenuViewmodel.menuDemoData.data?.user_data?.last_name ?? txtfieldValConst.emptyStr)
                    self.reloadProfileImage()
                }
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .reloadSideMenuData, object: nil)
    }
    
}
// MARK: TABLE VIEW SETUP
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 + (SideMenuViewmodel.menuDemoData.data?.product_categories?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.cartTableViewCell, for: indexPath) as! CartTableViewCell
            cell.TotalCartlabel.text = String(SideMenuViewmodel.menuDemoData.data?.total_carts ?? 0 )
            return cell
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.sideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = SideMenuViewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].name
            cell.cellImage.image = UIImage(named: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.sideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = pageTitleConstant.account
            cell.cellImage.image = UIImage(named: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.sideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = pageTitleConstant.Store_Locator
            cell.cellImage.image = UIImage(named: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.sideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = pageTitleConstant.My_Orders
            cell.cellImage.image = UIImage(named: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.sideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = pageTitleConstant.logOut
            cell.cellImage.image = UIImage(named: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.cartTableViewCell, for: indexPath) as! CartTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cartViewController = CartViewController.loadFromNib()
            self.navigationController?.pushViewController(cartViewController, animated: true)
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            let productViewController = ProductViewController.loadFromNib() as! ProductViewController
            productViewController.id = SideMenuViewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].id ?? 0
            self.navigationController?.pushViewController(productViewController, animated: true)
        }else if indexPath.row == 5{
            let MyAccountViewController = MyAccountViewController.loadFromNib() as! MyAccountViewController
            MyAccountViewController.accesstoken = SideMenuViewmodel.menuDemoData.data?.user_data?.access_token
            self.navigationController?.pushViewController(MyAccountViewController, animated: true)
        }else if indexPath.row == 6{
            let StoreLocatorViewController = StoreLocatorViewController.loadFromNib()
            self.navigationController?.pushViewController(StoreLocatorViewController, animated: true)
        }else if indexPath.row == 7{
            let MyOrdersViewController = MyOrdersViewController.loadFromNib()
            self.navigationController?.pushViewController(MyOrdersViewController, animated: true)
        }else if indexPath.row == 8{
            UserDefaults.standard.set(userDefConstant.empty, forKey: userDefConstant.accessToken)
            let loginViewController = LoginViewController.loadFromNib()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
        }
        else{
            stopActivityIndicator()
            print(errorConstant.error)
        }
    }
}

extension SideMenuViewController : ReloadSideMenuData{
    func reloadSidemenu() {
        viewmodel.fetchAccountDetails{
            responce in
            if responce{
                debugPrint(alertMsgConstant.ok)
            }
        }
    }
}


