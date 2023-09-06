//
//  OrderList.swift
//  Neostore
//
//  Created by Neosoft on 06/09/23.
//

import Foundation
class OrderListService{
    func getCartList(complition: @escaping (Result<OrderList,Error>)->Void){
        APIManager.shared.callRequest(apiCallType:.OrderList){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(OrderList.self, from: data)
                    complition(.success(responseData!))
                }
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                complition(.failure(error))
                
            }
        }
    }
    
    func getCartListDetails(order_id :Int,complition: @escaping (Result<OrderListDetials,Error>)->Void){
        let param = ["order_id":order_id]
        APIManager.shared.callRequest(apiCallType:.OrderListDetials(param: param)){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(OrderListDetials.self, from: data)
                    complition(.success(responseData!))
                }
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                complition(.failure(error))
                
            }
        }
    }
}
