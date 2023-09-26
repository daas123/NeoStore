//
//  RateViewController.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation
class RateViewModel{
    func sendRating(rating:Int,productId:Int, complition : @escaping (String)->Void){
        RatingService().sendRating(rate: rating , productId: productId){
            responce in
            switch responce{
            case .success(_):
                complition(txtfieldValConst.emptyStr)
            case .failure(let error):
                complition(error.localizedDescription)
            }
        }
    }
}
