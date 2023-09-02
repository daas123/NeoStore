//
//  AddAddressController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
struct adddetails{
    let firstcol:String
    let seconcol:String
}
class AddAddressController: UIViewController {
    
    let arrAddDetails = [adddetails(firstcol: "CITY", seconcol: "STATE"),
                         adddetails(firstcol: "ZIPCODE", seconcol: "COUNTRY")
                        ]
    @IBOutlet weak var AddAddressTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddAddressTableview.delegate = self
        AddAddressTableview.dataSource = self
        
        AddAddressTableview.separatorStyle = .none
        AddAddressTableview.backgroundColor = UIColor.clear
        
        AddAddressTableview.register(UINib(nibName: "AddAdressCell", bundle: nil), forCellReuseIdentifier: "AddAddressCell")
        AddAddressTableview.register(UINib(nibName: "AddAddressLandMarkCell", bundle: nil), forCellReuseIdentifier: "AddAddressLandMarkCell")
        AddAddressTableview.register(UINib(nibName: "AddAddressCityStateCell", bundle: nil), forCellReuseIdentifier: "AddAddressCityStateCell")
        AddAddressTableview.register(UINib(nibName: "AddAddressSaveAddressCell", bundle: nil), forCellReuseIdentifier: "AddAddressSaveAddressCell")
        // Do any additional setup after loading the view.
    }

}
extension AddAddressController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCell", for: indexPath) as! AddAdressCell
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressLandMarkCell", for: indexPath) as! AddAddressLandMarkCell
            return cell
        }else if indexPath.row == 2 || indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCityStateCell", for: indexPath) as! AddAddressCityStateCell
            cell.firstColumn.text = arrAddDetails[indexPath.row-2].firstcol
            cell.SecondColumn.text = arrAddDetails[indexPath.row-2].seconcol
            return cell
        }else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressSaveAddressCell", for: indexPath) as! AddAddressSaveAddressCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCell", for: indexPath) as! AddAdressCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    
    
}
