//
//  OrderModel.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation
struct AddToCart : Codable {
    let status : Int?
    let data : Bool?
    let total_carts : Int?
    let message : String?
    let user_msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case total_carts = "total_carts"
        case message = "message"
        case user_msg = "user_msg"
    }


}
