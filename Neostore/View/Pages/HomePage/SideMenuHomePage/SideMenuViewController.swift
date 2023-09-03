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
    @IBOutlet weak var SideMenuImage: UIImageView!
    @IBOutlet weak var SideMenuTableview: UITableView!
    
    var viewmodel = SideMenuViewmodel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // table view cell register
        SideMenuImage.image = UIImage(named: "saad")
        SideMenuImage.layer.cornerRadius = 33
        
        SideMenuTableview.delegate = self
        SideMenuTableview.dataSource = self
        
        // register the cell
        let reg = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        SideMenuTableview.register(reg, forCellReuseIdentifier: "SideMenuTableviewCell")
        // register the cart cell
        let cart = UINib(nibName: "CartTableViewCell", bundle: nil)
        SideMenuTableview.register(cart, forCellReuseIdentifier: "CartTableViewCell")
        
        getData()
    }
    //end of view did load
    
    func getData(){
        viewmodel.fetchAccountDetails{
            respose in
            DispatchQueue.main.async {
                if respose{
                    self.SideMenuTableview.reloadData()
                    self.userEmail.text = self.viewmodel.menuDemoData.data?.user_data?.email
                    self.userName.text = (self.viewmodel.menuDemoData.data?.user_data?.first_name ?? "Hello") + (self.viewmodel.menuDemoData.data?.user_data?.last_name ?? "User")
                    
                }
            }
        }
    }
    
}



extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 + (viewmodel.menuDemoData.data?.product_categories?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // for cart only
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.TotalCartlabel.text = String(viewmodel.menuDemoData.data?.total_carts ?? 0 )
            return cell
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.celllabel.text = viewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].name
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
            productViewController.id = viewmodel.menuDemoData.data?.product_categories?[indexPath.row-1].id ?? 0
            self.navigationController?.pushViewController(productViewController, animated: true)
        }else if indexPath.row == 5{
            
        }else if indexPath.row == 6{
            
        }else if indexPath.row == 7{
            
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
