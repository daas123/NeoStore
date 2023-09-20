//
//  ProductDetailsViewModel.swift
//  Neostore
//
//  Created by Neosoft on 28/08/23.
//


import Foundation
protocol GetDetailsPageDetails{
    func GetTitle()->String
    func GetProducer()->String
    func Getcost()->Int
    func GetRating()->Int
    func GetimageCount()->Int
    func GetDescription()->String
    func Getimagedata()->[Product_images]?
    
}


class ProductDetailsViewModel:GetDetailsPageDetails{
    
    var productDetailsData : productDetails?
    func getProductDetails(id:Int , complition : @escaping (Bool)->Void){
        ProductListApiService().getproductDetails(id: id){
            (responce) in
            switch responce{
            case .success(let data):
                self.productDetailsData = data
                complition(true)
            case .failure(let error ):
                print(error)
            }
        }
    }
    
    func GetTitle() -> String {
        return productDetailsData?.data?.name ?? "Invalid data"
    }
    
    func GetProducer() -> String {
        return productDetailsData?.data?.producer ?? "Invalid data"
    }
    
    func Getcost() -> Int {
        return productDetailsData?.data?.cost ?? 0
    }
    
    func GetRating() -> Int {
        return productDetailsData?.data?.rating ?? 0
    }
    
    func GetimageCount() -> Int {
        return productDetailsData?.data?.product_images?.count ?? 0
    }
    
    func GetDescription() -> String {
        return productDetailsData?.data?.description ?? "Invalid data"
    }
    func Getimagedata() -> [Product_images]? {
        return productDetailsData?.data?.product_images
    }
    
}


    
    


