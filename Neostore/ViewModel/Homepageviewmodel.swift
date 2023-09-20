//
//  homepageviewmodel.swift
//  Neostore
//
//  Created by Neosoft on 18/09/23.
//

import Foundation
class HomepageViewModel{
   var categoryData:[[String:Any]] = [
        ["name":"Table","lblPosition":positions.topRight,"imgName":"table","imgPosition":positions.bottomLeft],
        ["name":"Chairs","lblPosition":positions.bottomLeft,"imgName":"chair","imgPosition":positions.topRight],
        ["name":"Sofas","lblPosition":positions.topLeft,"imgName":"sofa","imgPosition":positions.bottomRight],
        ["name":"Beds","lblPosition":positions.bottomRight,"imgName":"bed","imgPosition":positions.topLeft]
    ]
    let collectionViewImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    
}
