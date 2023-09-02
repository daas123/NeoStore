//
//  AddressListViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class AddressListViewController: UIViewController {

    @IBOutlet weak var addressListTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addressListTableview.delegate = self
        addressListTableview.dataSource = self
        
        addressListTableview.register(UINib(nibName: "FirstViewCell", bundle: nil), forCellReuseIdentifier: "FirstViewCell")
        addressListTableview.register(UINib(nibName: "AddressListCell", bundle: nil), forCellReuseIdentifier: "AddressListCell")
        addressListTableview.register(UINib(nibName: "PlaceOrderCell", bundle: nil), forCellReuseIdentifier: "PlaceOrderCell")
    }

}
extension AddressListViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstViewCell", for: indexPath) as! FirstViewCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! AddressListCell
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceOrderCell", for: indexPath) as! PlaceOrderCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstViewCell", for: indexPath) as! FirstViewCell
            return cell
        }
    }
    
    
}
