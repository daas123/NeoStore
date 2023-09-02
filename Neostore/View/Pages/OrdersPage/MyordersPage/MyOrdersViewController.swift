//
//  MyOrdersViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyOrdersViewController: UIViewController {

    @IBOutlet weak var ordersPageTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersPageTableview.delegate = self
        ordersPageTableview.dataSource = self
        
        ordersPageTableview.register(UINib(nibName: "OrderIdCell", bundle: nil), forCellReuseIdentifier: "OrderIdCell")
        // Do any additional setup after loading the view.
    }



}
extension MyOrdersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdCell", for: indexPath) as! OrderIdCell
        return cell
    }
    
    
}
