//
//  MyOrdersViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit

class MyOrdersViewController: BaseViewController {
    
    let viewModel = OrderListViewModel()
    
    @IBOutlet weak var ordersPageTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: pageTitleConstant.My_Orders)
        setDeligate()
        registerCell()
        getdata()
    }
    
    func registerCell(){
        ordersPageTableview.register(UINib(nibName: "OrderIdCell", bundle: nil), forCellReuseIdentifier: "OrderIdCell")
    }
    
    func setDeligate(){
        ordersPageTableview.delegate = self
        ordersPageTableview.dataSource = self
    }
    
    func getdata(){
        viewModel.getorderList(){
            responce in
            DispatchQueue.main.async {
                if responce{
                    self.ordersPageTableview.reloadData()
                }else{
                    self.showAlert(msg: errorConstant.error)
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
