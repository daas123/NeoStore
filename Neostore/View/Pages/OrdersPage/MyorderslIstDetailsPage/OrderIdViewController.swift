//
//  OrderIdViewController.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//

import UIKit
import SDWebImage
class OrderIdViewController: BaseViewController {
    // MARK: FILE VARIABLE
    let viewmodel = OrderListViewModel()
    var orderDetialId : Int?
    
    @IBOutlet weak var orderIdTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: String(describing: orderDetialId))
        registerCell()
        setDeligate()
        getdata()
    }
    func registerCell(){
        orderIdTableView.register(UINib(nibName: cellRegNibConstant.orderIdListCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.orderIdListCell)
        orderIdTableView.register(UINib(nibName: cellRegNibConstant.orderIdTotalCell, bundle: nil), forCellReuseIdentifier: cellRegNibConstant.orderIdTotalCell)
    }
    func setDeligate(){
        orderIdTableView.delegate = self
        orderIdTableView.dataSource = self
    }
    
    static func loadFromNib()-> UIViewController{
        return OrderIdViewController(nibName: navigationVCConstant.myOrdersDetailsVC, bundle: nil)
    }
    
    func getdata(){
        self.startActivityIndicator()
        viewmodel.getOrderListDetials(order_id: orderDetialId ?? 0){
            responce in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.orderIdListCell, for: indexPath) as! OrderIdListCell
            cell.orderDetailsTitle.text = viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodName
            cell.orderDetailsQnt.text = String(viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].quantity ?? 0)
            cell.orderDetailsCategory.text = viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodCatName
            cell.orderDetailsCost.text = String(viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].total ?? 0)
            if let imageUrl = URL(string: viewmodel.orderListDetails?.data?.orderDetails[indexPath.row].prodImage ?? errorConstant.error) {
                cell.orderDetailsImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ImageConstants.default_img))
                }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == orderdetailsCount{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.orderIdTotalCell, for: indexPath) as! OrderIdTotalCell
            cell.orderDetailsTotal.text = String(viewmodel.orderListDetails?.data?.cost ?? 0)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellRegNibConstant.orderIdTotalCell, for: indexPath) as! OrderIdTotalCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
