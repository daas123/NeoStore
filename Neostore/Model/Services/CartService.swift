//
//  CartSerive.swift
//  Neostore
//
//  Created by Neosoft on 03/09/23.
//

import Foundation
class CartService{
    func editCart(productid :Int ,quantity:Int,complition: @escaping (Result<AddToCart,Error>)->Void){
        let param = ["product_id":productid,"quantity":quantity]
        APIManager.shared.callRequest(apiCallType:.productEditCart(param: param)){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(AddToCart.self, from: data)
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
    func DeleteCart(productid :Int,complition: @escaping (Result<AddToCart,Error>)->Void){
        let param = ["product_id":productid]
        APIManager.shared.callRequest(apiCallType:.productEditCart(param: param)){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(AddToCart.self, from: data)
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
    func getCartList(complition: @escaping (Result<CartData,Error>)->Void){
        APIManager.shared.callRequest(apiCallType:.CartList){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(CartData.self, from: data)
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
