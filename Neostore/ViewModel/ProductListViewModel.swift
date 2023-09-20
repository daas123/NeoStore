//
//  HomeProdCategoryViewModel.swift
//  Neostore
//
//  Created by Neosoft on 27/08/23.
//
import Foundation
import UIKit

enum positions{
    case topRight
    case topLeft
    case bottomLeft
    case bottomRight
}

protocol GetProductListDetails:AnyObject{
    func getCount()->Int
    func getProducer(row:Int) -> String
    func getCost(row:Int)-> Int
    func getId(row:Int)->Int
    func getName(row:Int)->String
    func getimage(row:Int)->String
    func getrating(row:Int)->Int
}
protocol RelaodProductListPage{
    func reloadProductlist()
}

class ProductCategoryViewModel{
    // For category data
    
    var productListDetailsData: ProductList?
    
    func GetProductList(id:Int , complition : @escaping (Bool)->Void){
            ProductListApiService().getProductList(product_category_id: id){
                (responce) in
                switch responce{
                case .success(let data):
                    self.productListDetailsData = data
                    complition(true)
                case .failure(let error):
                    print ("error not \(error)")
                }
                
            }
        
    }
    
}
extension ProductCategoryViewModel:GetProductListDetails{
    func getCount() -> Int {
        return productListDetailsData?.data?.count ?? 0
    }
    func getProducer(row:Int) -> String{
        return productListDetailsData?.data?[row].producer ?? "Invalid Row"
    }
    func getCost(row:Int)-> Int{
        return productListDetailsData?.data?[row].cost ?? 0
    }
    func getId(row:Int)->Int{
        return productListDetailsData?.data?[row].id ?? 0
    }
    func getName(row:Int)->String{
        return productListDetailsData?.data?[row].name ?? "invalid"
    }
    func getimage(row:Int)->String{
        return productListDetailsData?.data?[row].productImages ?? "invalid"
    }
    func getrating(row:Int)->Int{
        return productListDetailsData?.data?[row].rating ?? 0
    }
}
