//
//  OrderIdViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class OrderIdViewController: UIViewController {

    @IBOutlet weak var orderIdTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderIdTableView.delegate = self
        orderIdTableView.dataSource = self
        
        orderIdTableView.register(UINib(nibName: "OrderIdListCell", bundle: nil), forCellReuseIdentifier: "OrderIdListCell")
        orderIdTableView.register(UINib(nibName: "OrderIdTotalCell", bundle: nil), forCellReuseIdentifier: "OrderIdTotalCell")
        // Do any additional setup after loading the view.
    }

}
extension OrderIdViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdListCell", for: indexPath) as! OrderIdListCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdTotalCell", for: indexPath) as! OrderIdTotalCell
            return cell
        }
    }
    
    
}
