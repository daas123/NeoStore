//
//  SideMenuViewController.swift
//  Neostore
//
//  Created by Neosoft on 20/08/23.
//

import UIKit

struct menutabledetais{
    let name:String
    let image : String
}
class SideMenuViewController: UIViewController {

    
    @IBOutlet weak var SideMenuImage: UIImageView!
    @IBOutlet weak var SideMenuTableview: UITableView!
    let menuDemoData = [menutabledetais(name: "MyCart", image: "cart"),
                       menutabledetais(name: "Tables", image: "table.furniture"),
                       menutabledetais(name: "Sofa", image: "sofa")]
    
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
        if indexPath.row == 0{
            let cartcell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            return cartcell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableviewCell", for: indexPath) as! SideMenuTableViewCell
            cell.cellImage.image =  UIImage(systemName: menuDemoData[indexPath.row].image)
            cell.celllabel.text = menuDemoData[indexPath.row].name
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
