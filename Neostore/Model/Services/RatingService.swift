//
//  RatingOrderService.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation

class RatingService{
    func sendRating(rate:Int,productId:Int,complition: @escaping (Result<RatingModel,Error>) -> Void){
        let param = ["product_id":productId,"rating":rate]
        APIManager.shared.callRequest(apiCallType:.productRating(param: param)){
            (responce) in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(RatingModel.self, from: data)
                    complition(.success(responseData!))
                } catch {
                    complition(.failure(error))
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
