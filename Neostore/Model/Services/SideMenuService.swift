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
}
