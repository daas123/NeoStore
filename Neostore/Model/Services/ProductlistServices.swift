//
//  ProductlistServices.swift
//  Neostore
//
//  Created by Neosoft on 24/08/23.
//

import Foundation
import UIKit
class ProductListApiService{
    func getProductList(product_category_id : Int,completion: @escaping(Result<ProductList,Error>) -> Void){
        let params = ["product_category_id" : product_category_id] as [String : Any]
        
        APIManager.shared.callRequest(apiCallType: .productList(param: params)){ (response) in
            
            switch response {
            case .success(let value):
                do {
                    let responseData = try? JSONDecoder().decode(ProductList.self, from: value)
                    
                    completion(.success(responseData!))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("In Failure")
                debugPrint(error.localizedDescription)
                print("Wrong pass")
                completion(.failure(error))
            }
            
        }
    }
    func getImageProductlist(productUrl : String , Imagecomplition:@escaping(Result<UIImage,Error>)->Void){
        APIManager.shared.callRequest(apiCallType: .ImageFetching(imageurl: productUrl)){
            (responce) in
            switch responce {
            case .success(let data):
                if let image = UIImage(data: data) {
                    Imagecomplition(.success(image))
                }
            case .failure(let error):
                Imagecomplition(.failure(error))
            }
        }
    }
}

