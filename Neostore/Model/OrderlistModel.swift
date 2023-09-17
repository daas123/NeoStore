//
//  OrderlistModel.swift
//  Neostore
//
//  Created by Neosoft on 06/09/23.
//

import Foundation
struct OrderList: Codable {
    let status: Int
    let data: [OrderDetails]
    let message, userMsg: String

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct OrderDetails: Codable {
    let id, cost: Int
    let created: String
}


// for order list details


struct OrderListDetials: Codable {
    let status: Int
    let data: OrderDetailsdata?
}
// MARK: - DataClass
struct OrderDetailsdata: Codable {
    let id, cost: Int
    let address: String
    let orderDetails: [OrderDetailsList]

    enum CodingKeys: String, CodingKey {
        case id, cost, address
        case orderDetails = "order_details"
    }
}
struct OrderDetailsList: Codable {
    let id, orderID, productID, quantity: Int
    let total: Int
    let prodName, prodCatName: String
    let prodImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case productID = "product_id"
        case quantity, total
        case prodName = "prod_name"
        case prodCatName = "prod_cat_name"
        case prodImage = "prod_image"
    }
}
