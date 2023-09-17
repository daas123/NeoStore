//
//  AccountModel.swift
//  Neostore
//
//  Created by Neosoft on 03/09/23.
//

import Foundation

struct FetchAccount: Codable {
    var status: Int?
    var data: FetchDetails?
    var message: String?
    var user_msg: String?
    
    enum codingKeys: String,CodingKey {
        case status = "status"
        case data = "data"
        case message = "message"
        case user_msg = "user_msg"
    }
}

struct FetchDetails: Codable {
    var user_data: UserDetail?
    var product_categories: [ProductCategory]?
    var total_carts: Int?
    var total_orders: Int?
    
    enum codingKeys: String,CodingKey {
        case user_data = "user_data"
        case product_categories = "product_categories"
        case total_carts = "total_carts"
        case total_orders = "total_orders"
    }
}

struct ProductCategory: Codable {
    var id: Int?
    var name: String?
    var icon_image: String?
    var created: String?
    var modified: String?
    
    enum codingKeys: String,CodingKey {
        case id = "id"
        case name = "name"
        case icon_image = "icon_image"
        case created = "created"
        case modified = "modified"
    }
}
