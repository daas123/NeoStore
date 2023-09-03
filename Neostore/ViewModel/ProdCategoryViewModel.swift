//
//  HomeProdCategoryViewModel.swift
//  Neostore
//
//  Created by Neosoft on 27/08/23.
//

//"id":1,"product_category_id":1,"name":"Centre Coffee Table","producer":"Luna","description":"Mild
//Steel Base In Poder Coated White Finish.8 mm Tempered Glass Table Top.Bottom Shelf In Paimted Brown
//Glass.","cost":5000,"rating":3,"view_count":30629,"created":"2015-09-07T09:24:05+0000","modified":"2023-08-27T09:37:55+0000","product_images":"http:\/\/staging.php-dev.in:8844\/trainingapp\/uploads\/prod_img\/thumb\/medium\/9dc6234da018916e545011fa1.jpeg"}

import Foundation
import UIKit

// posotion for category view contoller
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
    
    func imageDataProductList(stringurl : String ,complition : @escaping (UIImage)->Void){
        ProductListApiService().getImageProductlist(productUrl: stringurl){
            (responce) in
            switch responce{
            case .success(let imagedata):
                complition(imagedata)
            case .failure(let error):
                debugPrint("no image rerived , Error : \(error.localizedDescription)")
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
