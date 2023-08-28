//
//  ProductDetailsViewModel.swift
//  Neostore
//
//  Created by Neosoft on 28/08/23.
//

//struct DetailsProduct{
//    let name : String
//    let producer :String
//    let dataDescription : String
//    let cost : Int
//    let rating : Int
//    let productImages : String
//}

import Foundation
class ProductDetailsViewModel{
    func getProductDetails(id:Int , complition : @escaping (Result<[DetailsProduct],Error>)->Void){
        ProductListApiService().getproductDetails(id: id){
            (responce) in
            switch responce{
            case .success(let data):
                if let mainData = data.data, let imageArray = mainData.product_images {
                    var newdata = [DetailsProduct]()
                    for productImage in imageArray {
                        let detailsProduct = DetailsProduct(
                            name: mainData.name!,
                            producer: mainData.producer!,
                            dataDescription: mainData.description!,
                            cost: mainData.cost!,
                            rating: mainData.rating!
                        )
                        newdata.append(detailsProduct)
                    }
                    print(newdata)
                    print(imageArray.first?.image)
                }
                //                complition(.success(newdata))
            case .failure(let error ):
                print(error)
                
            }
        }
    }
}
                //
                //if let detailsData = data.data {
                //    if let products = detailsData.product_images {
                //        for product in products {
                //            let detailsProduct = DetailsProduct(
                //                name: detailsData.name ?? "",
                //                producer: detailsData.producer ?? "",
                //                dataDescription: detailsData.description ?? "",
                //                cost: detailsData.cost ?? 0,
                //                rating: detailsData.rating ?? 0,
                //                productImages: product.image ?? ""
                //            )
                //            newdata.append(detailsProduct)
                //        }
                //    }
                //}
                
                
                //
                //productDetails(status: 200, data: Optional(Neostore.Details(id: Optional(1), product_category_id: Optional(1), name: Optional("Centre Coffee Table"), producer: Optional("Luna"), description: Optional("Mild Steel Base In Poder Coated White Finish.8 mm Tempered Glass Table Top.Bottom Shelf In Paimted Brown Glass."), cost: Optional(5000), rating: Optional(3), view_count: Optional(30652), created: Optional("2015-09-07T09:24:05+0000"), modified: Optional("2023-08-28T12:22:39+0000"), product_images: Optional([Neostore.Product_images(id: Optional(1), product_id: Optional(1), image: Optional("http://staging.php-dev.in:8844/trainingapp/uploads/prod_img/thumb/medium/9dc6234da018916e545011fa1.jpeg"), created: "2015-09-07T09:40:00+0000", modified: "2015-09-07T09:40:00+0000"), Neostore.Product_images(id: Optional(6), product_id: Optional(1), image: Optional("http://staging.php-dev.in:8844/trainingapp/uploads/prod_img/thumb/medium/1bfdac02ced672dd1e8e8976c.jpeg"), created: "2015-09-07T09:44:11+0000", modified: "2015-09-07T09:44:11+0000")]))))
