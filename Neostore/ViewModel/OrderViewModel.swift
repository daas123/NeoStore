//
//  OrderViewModel.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation


class OrderviewModel{
    func AddToCart(productid :Int ,quantity:String, complition : @escaping (String?)->Void){
        validation().addToCart(Quantity: quantity){
                (resultMsg) in
            if resultMsg == txtfieldValConst.emptyStr{
                    OrderService().AddtoCart(productid: productid, quantity: Int(quantity) ?? 0){
                        responce in
                        switch responce{
                        case .success(_):
                            complition(txtfieldValConst.emptyStr)
                        case .failure(let error):
                            complition(error.localizedDescription)
                        }
                    }
                }else{
                    complition(resultMsg)
                }
            }
        
    }
    
    
}
