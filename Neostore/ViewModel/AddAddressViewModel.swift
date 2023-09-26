//
//  AddAddressViewModel.swift
//  Neostore
//
//  Created by Neosoft on 05/09/23.
//

import Foundation

struct AddressFormate:Codable{
    var address: String
    var landmark : String
    var city : String
    var state : String
    var zipCode : Int
    var country : String
}
class AddAddressViewModel {
    let userDefaults = UserDefaults.standard
    var addressData: [AddressFormate] {
            get {
                if let data = UserDefaults.standard.data(forKey: userDefConstant.myAddress),
                   let addresses = try? JSONDecoder().decode([AddressFormate].self, from: data) {
                    return addresses
                }
                return []
            }
            set {
                if let encodedData = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(encodedData, forKey: userDefConstant.myAddress)
                }
            }
        }
    func addAddressData(address:String,landmark:String,city:String,state:String,zipCode:Int,country:String,complition: @escaping (String)->Void){
        
        validation().addAddressValidation(address: address, landmard: landmark, city: city, state: state, zipcode: zipCode, country: country){
            resultMsg in
            if resultMsg == txtfieldValConst.emptyStr {
                var newAddress = AddressFormate(
                            address: address,
                            landmark: landmark,
                            city: city,
                            state: state,
                            zipCode: zipCode,
                            country: country
                        )
                var addresses = self.addressData
                addresses.append(newAddress)
                self.addressData = addresses
                        
                complition(txtfieldValConst.emptyStr)
            }else{
                complition(resultMsg)
            }
            
        }
    }
    
    func OrderCart(address:String ,complition: @escaping (Bool)->Void){
        OrderService().orderCart(address: address){
            responce in
            switch responce{
            case .success(_):
                complition(true)
            case .failure(_):
                complition(false)
            }
        }
    }
}
