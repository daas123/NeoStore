//
//  ProductListModel.swift
//  Neostore
//
//  Created by Neosoft on 24/08/23.
//

import Foundation

// model for getting product list
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


// model for data stroing in productlist page
// model for side menu table in home view controller
struct menutabledetais{
    let name:String
    let image : String
    let category : sidemuneCategory
}
enum sidemuneCategory:String{
    case cart
    case logout
    case productdetails
    case myaccount
    case storelocator
    case myorder
}



// model for productlist
struct productDetails : Codable {
    let status : Int
    let data : Details?
}

struct Details : Codable {
    let id : Int?
    let product_category_id : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Int?
    let view_count : Int?
    let created : String?
    let modified : String?
    let product_images : [Product_images]?

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
        case product_images = "product_images"
    }
}

struct Product_images:Codable{
    let id : Int?
    let product_id : Int?
    let image : String?
    let created : String
    let modified : String
}


// data stroring model for product details page
struct DetailsProduct{
    let name : String
    let producer :String
    let dataDescription : String
    let cost : Int
    let rating : Int
    let image1 : String
}


//setting the title for product

enum productListTile:String{
    case Tables
    case Chairs
    case Sofas
    case Cupboards
    case error
}

