//
//  OrderIdViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
import SDWebImage
class OrderIdViewController: UIViewController {
    let viewmodel = OrderListViewModel()
    var orderDetialId = Int()
    @IBOutlet weak var orderIdTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderIdTableView.delegate = self
        orderIdTableView.dataSource = self
        title = "Order ID : \(orderDetialId)"
        orderIdTableView.register(UINib(nibName: "OrderIdListCell", bundle: nil), forCellReuseIdentifier: "OrderIdListCell")
        orderIdTableView.register(UINib(nibName: "OrderIdTotalCell", bundle: nil), forCellReuseIdentifier: "OrderIdTotalCell")
        // Do any additional setup after loading the view.
        getdata()
    }
    func getdata(){
        viewmodel.getOrderListDetials(order_id: orderDetialId){
            responce in
            DispatchQueue.main.async {
                self.orderIdTableView.reloadData()
            }
        }
    }

}
extension OrderIdViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1 + (viewmodel.orderListDetails?.data?.orderDetails.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderdetailsCount = (viewmodel.orderListDetails?.data?.orderDetails.count ?? 0)
        if indexPath.row <= (orderdetailsCount - 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdListCell", for: indexPath) as! OrderIdListCell
            cell.orderDetailsTitle.text = viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodName
            cell.orderDetailsQnt.text = String(viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].quantity ?? 0)
            cell.orderDetailsCategory.text = viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodCatName
            cell.orderDetailsCost.text = String(viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].total ?? 0)
            if let imageUrl = URL(string: viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodImage ?? "invalid") {
                    cell.orderDetailsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "bg.jpg"))
                }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == orderdetailsCount{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdTotalCell", for: indexPath) as! OrderIdTotalCell
            cell.orderDetailsTotal.text = String(viewmodel.orderListDetails?.data?.cost ?? 0)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderIdTotalCell", for: indexPath) as! OrderIdTotalCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
