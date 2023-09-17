//
//  OrderModel.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation


// it was used for both addtocart and editcart
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


struct CartData: Codable {
    let status: Int
    let data: [CartList]?
    let count, total: Int
}

// MARK: - Datum
struct CartList: Codable {
    let id, productID, quantity: Int
    let product: CartListData?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case quantity, product
    }
}

// MARK: - Product
struct CartListData: Codable {
    let id: Int
    let name: String
    let cost: Int
    let productCategory: String
    let productImages: String
    let subTotal: Int

    enum CodingKeys: String, CodingKey {
        case id, name, cost
        case productCategory = "product_category"
        case productImages = "product_images"
        case subTotal = "sub_total"
    }
}


struct OrderCart: Codable {
    let status: Int
    let message: String
    let user_msg : String
}
