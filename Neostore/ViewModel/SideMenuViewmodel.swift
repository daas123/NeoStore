//
//  SideMenuViewmodel.swift
//  Neostore
//
//  Created by Neosoft on 02/09/23.
//  cart   table.furniture  chair.fill  sofa.fill   bed.double

import Foundation

protocol ReloadSidemenuDetails{
    func reloadSideMenu()
}
class SideMenuViewmodel{
    var menuDemoData = FetchAccount()
    var sideMenuTableImages = ["","table.furniture","chair.fill","sofa.fill","bed.double","person.fill","mappin.and.ellipse","note.text","arrow.uturn.left.circle"]
    func fetchAccountDetails(complition : @escaping (Bool)->Void){
        FetchAccountWEbService().getAccountdata(){
            responce in
            switch responce{
            case .success(let data):
                self.menuDemoData = data
                complition(true)
            case .failure(let error):
                print(error.localizedDescription)
                complition(false)
            }
    
        }
    }

}


