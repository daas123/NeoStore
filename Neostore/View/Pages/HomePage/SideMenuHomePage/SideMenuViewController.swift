//
//  SideMenuViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit
class SideMenuViewController: UIViewController {

    
    @IBOutlet weak var SideMenuImage: UIImageView!
    @IBOutlet weak var SideMenuTableview: UITableView!
    let menuDemoData = [menutabledetais(name: "MyCart", image: "cart", category: .cart ),
                        menutabledetais(name: "Tables", image: "table.furniture", category: .productdetails),
                        menutabledetais(name: "Chairs", image: "chair.fill", category: .productdetails),
                        menutabledetais(name: "Sofa", image: "sofa.fill", category: .productdetails),
                        menutabledetais(name: "Bed", image: "bed.double", category: .productdetails),
                        menutabledetais(name: "My Account", image: "person.fill", category: .myaccount),
                        menutabledetais(name: "Store Locator", image: "mappin.and.ellipse", category: .storelocator),
                        menutabledetais(name: "My Order", image: "list.clipboard", category: .myorder),
                        menutabledetais(name: "Logout", image: "arrow.uturn.left.circle", category: .logout),
    ]
    
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
    }

}
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuDemoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // for cart only
        switch menuDemoData[indexPath.row].category{
        case .productdetails :
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
                    cell.cellImage.image =  UIImage(systemName: menuDemoData[indexPath.row].image)
                    cell.celllabel.text = menuDemoData[indexPath.row].name
                    return cell
        case .cart :
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            return cell
//        case .myaccount :
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
//            return cell
//        case .myorder :
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
//            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
                    cell.cellImage.image =  UIImage(systemName: menuDemoData[indexPath.row].image)
                    cell.celllabel.text = menuDemoData[indexPath.row].name
                    return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch menuDemoData[indexPath.row].category{
        case .productdetails:
            let selectedId = indexPath.row
            print(selectedId)
            let productViewController = ProductViewController(nibName: "ProductViewController", bundle: nil)
            productViewController.id = selectedId
            self.navigationController?.pushViewController(productViewController, animated: true)
            
        case .logout:
            UserDefaults.standard.set("", forKey: "accessToken")
            let LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(LoginViewController, animated: true)
        default:
            print("hello")
        }
        
    }
    
}
