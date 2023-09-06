//
//  loginServices.swift
//  Neostore
//
//  Created by Neosoft on 23/08/23.
//

import Foundation

import Foundation

class LoginWebService {
    func loginAction(email: String, password: String, completion: @escaping (Result<(User?, AuthResponse?), Error>) -> Void) {
        let param = ["email": email, "password": password]
        APIManager.shared.callRequest(apiCallType: .userLogin(param: param)) { response in
            do {
                switch response {
                case .success(let data):
                    guard let retrievedData = data as? Data else {
                        print("Error in model")
                        return
                    }
                    
                    if let jsondata = try? JSONDecoder().decode(User.self, from: retrievedData) {
                        completion(.success((jsondata, nil)))
                    }
                    
                    if let jsondata2 = try? JSONDecoder().decode(AuthResponse.self, from: retrievedData) {
                        completion(.success((nil, jsondata2)))
                    }
                    
                case .failure(let error):
                    throw error
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}



