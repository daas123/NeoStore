//
//  RateViewController.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation
class RateViewModel{
    func sendRating(rating:Int,productId:Int, complition : @escaping (Bool,String)->Void){
        RatingService().sendRating(rate: rating , productId: productId){
            responce in
            switch responce{
            case .success(let data):
                complition(true, data.message)
            case .failure(let error):
                complition(false , error.localizedDescription)
            }
        }
    }
}
