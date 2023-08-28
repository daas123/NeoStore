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
class ProductCategoryViewModel{
    func GetProductList(id:Int , complition : @escaping ([productList])->Void){
        if (1...4).contains(id){
            ProductListApiService().getProductList(product_category_id: id){
                (responce) in
                switch responce{
                case .success(let data):
                    var newdata = [productList]()
                    if let data = data.data{
                        for productData in data{
                            let product = productList(name: productData.name!,
                                                      cost: productData.cost!,
                                                      producer: productData.producer!,
                                                      ratings: productData.rating!,
                                                      image: productData.productImages!)
                            
                            newdata.append(product)  // Append each product to the array
                        }
                        
                    }
                    complition(newdata)
                case .failure(let error):
                    print ("error not \(error)")
                }
                
            }
        }else{
            print("not selected valid cell")
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
