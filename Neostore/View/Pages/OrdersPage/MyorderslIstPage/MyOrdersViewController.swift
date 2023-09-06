//
//  MyOrdersViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    let viewModel = OrderListViewModel()

    @IBOutlet weak var ordersPageTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // for activating navigation bar
        
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
        
        
        // setting title for navigation bar
        title = "Order List"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        ordersPageTableview.delegate = self
        ordersPageTableview.dataSource = self
        
        ordersPageTableview.register(UINib(nibName: "OrderIdCell", bundle: nil), forCellReuseIdentifier: "OrderIdCell")
        // Do any additional setup after loading the view.
        getdata()
    }
    
    func getdata(){
        viewModel.getorderList(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.ordersPageTableview.reloadData()
                }else{
                    self.showAlert(msg: "erorr")
                }
            }
            
        }
    }



}
extension MyOrdersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.OrderListData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdCell", for: indexPath) as! OrderIdCell
        cell.orderListDetails.text = viewModel.OrderListData?.data[indexPath.row].created
        cell.orderListOrderId.text = String(viewModel.OrderListData?.data[indexPath.row].id ?? 0)
        cell.orderListTotalCost.text = String(viewModel.OrderListData?.data[indexPath.row].cost ?? 0)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let OrderIdViewController = OrderIdViewController(nibName: "OrderIdViewController", bundle: nil)
        OrderIdViewController.orderDetialId = viewModel.OrderListData?.data[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(OrderIdViewController, animated: true)
    }
    
}
