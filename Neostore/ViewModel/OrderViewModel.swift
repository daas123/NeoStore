//
//  OrderViewModel.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation


class OrderviewModel{
    func AddToCart(productid :Int ,quantity:String, complition : @escaping (Bool,String?)->Void){
        validation().addToCart(Quantity: quantity){
                (Result,msg) in
                if Result{
                    OrderService().AddtoCart(productid: productid, quantity: Int(quantity) ?? 0){
                        responce in
                        switch responce{
                        case .success(let data):
                            complition(true, data.message)
                        case .failure(let error):
                            complition(false , error.localizedDescription)
                        }
                    }
                }else{
                    complition(false,msg)
                }
            }
        
    }
    
    
}
