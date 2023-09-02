//
//  OrderService.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation
class OrderService{
    func AddtoCart(productid :Int ,quantity:Int,complition: @escaping (Result<AddToCart,Error>) -> Void){
        let param = ["product_id":productid,"quantity":quantity]
        APIManager.shared.callRequest(apiCallType:.productAddToCart(param: param)){
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

}
