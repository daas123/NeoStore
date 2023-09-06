//
//  OrderListViewModel.swift
//  Neostore
//
//  Created by Neosoft on 06/09/23.
//

import Foundation
class OrderListViewModel{
    
    var OrderListData : OrderList?
    var orderListDetails : OrderListDetials?
    func getorderList(complition : @escaping (Bool)->Void){
        OrderListService().getCartList(){
            responce in
            switch responce{
            case .success(let data):
                self.OrderListData = data
                complition(true)
            case .failure(_):
                complition(false)
            }
        }
    }
    
    func getOrderListDetials(order_id:Int ,complition : @escaping (Bool)->Void){
        OrderListService().getCartListDetails(order_id: order_id){
            responce in
            switch responce{
            case .success(let data):
                self.orderListDetails = data
                complition(true)
            case .failure(let error):
                complition(false)
            }
        }
    }
}
