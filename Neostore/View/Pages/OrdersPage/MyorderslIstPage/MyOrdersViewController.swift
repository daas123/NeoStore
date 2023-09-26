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
        ordersPageTableview.register(UINib(nibName: cellRegNibConstant.orderIdCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.orderIdCell)
    }
    
    func setDeligate(){
        ordersPageTableview.delegate = self
        ordersPageTableview.dataSource = self
    }
    
    static func loadFromNib()-> UIViewController{
        return MyOrdersViewController(nibName: navigationVCConstant.myOrdersVC, bundle: nil)
    }
    // MARK: APICALL
    
    func getdata(){
        self.startActivityIndicator()
        viewModel.getorderList(){
            responce in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.orderIdCell, for: indexPath) as! OrderIdCell
        cell.orderListDetails.text = viewModel.OrderListData?.data[indexPath.row].created
        cell.orderListOrderId.text = String(viewModel.OrderListData?.data[indexPath.row].id ?? 0)
        cell.orderListTotalCost.text = String(viewModel.OrderListData?.data[indexPath.row].cost ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let OrderIdViewController = OrderIdViewController.loadFromNib() as! OrderIdViewController
        OrderIdViewController.orderDetialId = viewModel.OrderListData?.data[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(OrderIdViewController, animated: true)
    }
    
}
