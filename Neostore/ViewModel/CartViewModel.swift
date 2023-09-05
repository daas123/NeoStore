//
//  EditCartViewModel.swift
//  Neostore
//
//  Created by Neosoft on 03/09/23.
//

import Foundation
import UIKit
class CartViewModel{
    var cartData : CartData?
    var cartPickerviewData = [0,1,2,3,4,5,6,7]
    func editToCart(productid :Int ,quantity:String, complition : @escaping (Bool,String?)->Void){
        validation().addToCart(Quantity: quantity){
            (Result,msg) in
            if Result{
//                OrderService().(productid: productid, quantity: Int(quantity) ?? 0)
                CartService().editCart(productid: productid, quantity: Int(quantity) ?? 0){
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
    
    func getCartDetails(complition:@escaping(Bool)->Void){
        CartService().getCartList(){
            responce in
            switch responce{
            case .success(let data):
                self.cartData = data
                complition(true)
            case .failure(let error):
                complition(false)
            }
        }
    }
    
    func deleteCartDetails(id : Int ,complition:@escaping(Bool)->Void){
        CartService().DeleteCart(productid: id){
            responce in
            switch responce{
            case .success(let data):
                complition(true)
            case .failure(let error):
                complition(false)
            }
        }
        
    }
}
