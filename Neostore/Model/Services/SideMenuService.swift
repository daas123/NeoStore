//
//  sideMenuService.swift
//  Neostore
//
//  Created by Neosoft on 03/09/23.
//

import Foundation
class FetchAccountWEbService{
    func getAccountdata(complition: @escaping (Result<FetchAccount,Error>) -> Void){
        APIManager.shared.callRequest(apiCallType: .fetchAccountDetails){
            responce in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(FetchAccount.self, from: data)
                    complition(.success(responseData!))
                }
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    func editAccountdata(first_name:String ,last_name:String,email:String,dob:String,phone_no:String,profile_pic:String,complition: @escaping (Result<FetchAccount,Error>) -> Void){
        let param = ["first_name":first_name, "last_name": last_name, "email": email, "dob": dob, "phone_no": phone_no , "profile_pic":""]
        APIManager.shared.callRequest(apiCallType: .EditAccountDetails(param: param)){
            responce in
            switch responce{
            case .success(let data):
                do {
                    let responseData = try? JSONDecoder().decode(FetchAccount.self, from: data)
                    if responseData?.status == 200{
                        complition(.success(responseData!))
                    }else{
                        complition(.failure(Error.self as! Error))
                    }
                }
            case .failure(let error):
                complition(.failure(error))
            }
        }
        
    }
}
