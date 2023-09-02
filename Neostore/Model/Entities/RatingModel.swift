//
//  File.swift
//  Neostore
//
//  Created by Neosoft on 01/09/23.
//

import Foundation

struct RatingModel:Codable{
    let status : Int
    let data : ratingData?
    let message : String
    let user_msg : String
}
struct ratingData : Codable {
    let id : Int?
    let product_category_id : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Double?
    let view_count : Int?
    let created : String?
    let modified : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_category_id = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case view_count = "view_count"
        case created = "created"
        case modified = "modified"
    }


}


