//
//  SideMenuViewmodel.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//  cart   table.furniture  chair.fill  sofa.fill   bed.double

import Foundation
import UIKit

protocol ReloadSidemenuDetails{
    func reloadSideMenu()
}
class SideMenuViewmodel{
    static var menuDemoData = FetchAccount()
    var sideMenuTableImages = ["cart","table","chair","sofa","bed","person","location","order","logout"]
    func fetchAccountDetails(complition : @escaping (Bool)->Void){
        
        // setting the acccount image as user default wehn first time
        
        FetchAccountWEbService().getAccountdata(){
            responce in
            switch responce{
            case .success(let data):
                SideMenuViewmodel.menuDemoData = data
                complition(true)
            case .failure(let error):
                print(error.localizedDescription)
                complition(false)
            }
            
        }
    }
    
}


