//
//  loginServices.swift
//  Neostore
//
//  Created by Neosoft on 23/08/23.
//

import Foundation

class LoginWebService {
    func loginAction(email : String , password :String , complition : @escaping (Result<User,Error>)->Void){
        let param = ["email":email , "password":password]
        APIManager.shared.callRequest(apiCallType: .userLogin(param: param)){
            (responce) in
            switch responce{
            case .success(let data):
                if let retriveddata = data as? Data {
                    do {
                        let jsondata = try? JSONDecoder().decode(User.self, from: retriveddata)
                        complition(.success(jsondata!))
                    }catch{
                        print("Not able to decode")
                    }
                }
                
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}



//
//class loginApiService:NSObject{
//    func LoginUser(Username: String, pass: String , completion: @escaping(Result<User,Error>) -> Void){
//
//        let params = ["email" : Username, "password" : pass ]
//
//        APIManager.shared.callRequest(apiCallType: .userLogin(param: params)){ (response) in
//            switch response {
//            case .success(let value):
//                if let content = value as? Data {
//                    do {
//                        let responseData = try JSONDecoder().decode(User.self, from: content)
//                        completion(.success(responseData))
//                    } catch {
//                        print(error)
//                    }
//                }
//                else{
//                    print("no error")
//                }
//            case .failure(let error):
//                print("In Failure")
//                debugPrint(error.localizedDescription)
//                print("Wrong pass")
//                completion(.failure(error))
//            }
//        }
//    }
//}
