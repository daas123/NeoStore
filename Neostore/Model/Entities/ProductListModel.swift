//
//  ProductListModel.swift
//  Neostore
//
//  Created by Neosoft on 24/08/23.
//

import Foundation
struct ProductList: Codable {
    let status: Int?
    let data: [ProductListdata]?
    let message, userMsg: String?

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct ProductListdata: Codable {
    let id, productCategoryID: Int?
    let name, producer, datumDescription: String?
    let rating, viewCount: Int?
    let created, modified: String?
    let productImages: String?
    let cost: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productCategoryID = "product_category_id"
        case name, producer
        case datumDescription = "description"
        case cost, rating
        case viewCount = "view_count"
        case created, modified
        case productImages = "product_images"
    }
}

struct productList{
    var name : String
    var cost : Int
    var producer : String
    var ratings : Int
    var image : String
    
}
struct menutabledetais{
    let name:String
    let image : String
}
