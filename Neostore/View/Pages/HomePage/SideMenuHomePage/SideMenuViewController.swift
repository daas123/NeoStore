//
//  SideMenuViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
class SideMenuViewController: UIViewController {
    
    
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var sideMenuImage: UIImageView!
    @IBOutlet weak var sideMenuTableview: UITableView!
    
    var viewmodel = SideMenuViewmodel()
   
    override func viewDidLoad() {
        super.viewDidLoad()        
        // table view cell register
        sideMenuImage.image = UIImage(named: "saad")
        sideMenuImage.layer.cornerRadius = 33
        
        sideMenuTableview.delegate = self
        sideMenuTableview.dataSource = self
        
        // register the cell
        let reg = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        sideMenuTableview.register(reg, forCellReuseIdentifier: "SideMenuTableviewCell")
        // register the cart cell
        let cart = UINib(nibName: "CartTableViewCell", bundle: nil)
        sideMenuTableview.register(cart, forCellReuseIdentifier: "CartTableViewCell")
        getData()
    }
    //end of view did load
    
    func getData(){
        viewmodel.fetchAccountDetails{
            respose in
            DispatchQueue.main.async {
                if respose{
                    self.sideMenuTableview.reloadData()
                    self.userEmail.text = SideMenuViewmodel.menuDemoData.data?.user_data?.email
                    self.userName.text = (SideMenuViewmodel.menuDemoData.data?.user_data?.first_name ?? "Hello") + (SideMenuViewmodel.menuDemoData.data?.user_data?.last_name ?? "User")
                    if let imageUrl = URL(string:SideMenuViewmodel.menuDemoData.data?.user_data?.profile_pic ?? "invalid") {
                        self.sideMenuImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
                        } else {
                            self.sideMenuImage.image = UIImage(named: "bg.jpg")
                        }
                    
                }
            }
        }
    }
    
}



extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 + (SideMenuViewmodel.menuDemoData.data?.product_categories?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // for cart only
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.TotalCartlabel.text = String(SideMenuViewmodel.menuDemoData.data?.total_carts ?? 0 )
            return cell
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = SideMenuViewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].name
            cell.cellImage.image = UIImage(systemName: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = "MyAccount"
            cell.cellImage.image = UIImage(systemName: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = "Store Locator"
            cell.cellImage.image = UIImage(systemName: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = "My Orders"
            cell.cellImage.image = UIImage(systemName: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }else if indexPath.row == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = "logOut"
            cell.cellImage.image = UIImage(systemName: viewmodel.sideMenuTableImages[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cartViewController = CartViewController(nibName: "CartViewController", bundle: nil)
            
            self.navigationController?.pushViewController(cartViewController, animated: true)
            
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            let productViewController = ProductViewController(nibName: "ProductViewController", bundle: nil)
            let selectedId = indexPath.row
            productViewController.id = SideMenuViewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].id ?? 0
            
            self.navigationController?.pushViewController(productViewController, animated: true)
            
        }else if indexPath.row == 5{
            let MyAccountViewController = MyAccountViewController(nibName: "MyAccountViewController", bundle: nil)
           
            self.navigationController?.pushViewController(MyAccountViewController, animated: true)
        }else if indexPath.row == 6{
            let StoreLocatorViewController = StoreLocatorViewController(nibName: "StoreLocatorViewController", bundle: nil)
            
            self.navigationController?.pushViewController(StoreLocatorViewController, animated: true)
            
        }else if indexPath.row == 7{
            let MyOrdersViewController = MyOrdersViewController(nibName: "MyOrdersViewController", bundle: nil)
            
            self.navigationController?.pushViewController(MyOrdersViewController, animated: true)
            
        }else if indexPath.row == 8{
            UserDefaults.standard.set("", forKey: "accessToken")
            let LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            
            self.navigationController?.pushViewController(LoginViewController, animated: true)
        }
        else{
            print("not selected proper row")
        }
        
    }
    
}

