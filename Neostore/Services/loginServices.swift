//
//  loginServices.swift
//  Neostore
//
//  Created by Neosoft on 23/08/23.
//

import Foundation

import Foundation

class LoginWebService {
    func loginAction(email: String, password: String, completion: @escaping (Result<(User?,UserResponseFalied?,UserDataError?), Error>) -> Void) {
        let param = ["email": email, "password": password]
        APIManager.shared.callRequest(apiCallType: .userLogin(param: param)) { response in
            switch response {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success((user,nil,nil)))
                } catch {
                    do {
                        let userResponseFalied = try JSONDecoder().decode(UserResponseFalied.self, from: data)
                        completion(.success((nil, userResponseFalied,nil)))
                    }catch {
                        do {
                            let userDataError = try JSONDecoder().decode(UserDataError.self, from: data)
                            completion(.success((nil,nil,userDataError)))
                        }catch {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func changeAction(old_password: String, password: String,confirm_password:String, completion: @escaping (Result<(ForgetUser?,UserDataError?),Error>)->Void){
        let param = ["old_password":old_password,"password":password,"confirm_password":confirm_password]
        APIManager.shared.callRequest(apiCallType: .ChangePasword(param: param)) { response in
            switch response {
            case .success(let data):
                do {
                    let forgetPassSucces = try JSONDecoder().decode(ForgetUser.self, from: data)
                    if forgetPassSucces.status == 200{
                        completion(.success((forgetPassSucces,nil)))
                    }else{
                        debugPrint("error")
                    }
                }catch{
                    do {
                        let userDataError = try JSONDecoder().decode(UserDataError.self, from: data)
                        completion(.success((nil,userDataError)))
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error ):
                completion(.failure(error))
            }
        }
        
    }
    
    func forgetAction(email:String, completion: @escaping (Result<(ForgetUser?,UserDataError?),Error>)->Void){
        let param = ["email":email]
        APIManager.shared.callRequest(apiCallType: .ForgetPassword(param: param)) { response in
            switch response {
            case .success(let data):
                do {
                    let forgetUser = try JSONDecoder().decode(ForgetUser.self, from: data)
                    completion(.success((forgetUser,nil)))
                }catch{
                    do {
                        let userDataError = try? JSONDecoder().decode(UserDataError.self, from: data)
                        completion(.success((nil,userDataError)))
                    }
                }
            case .failure(let error ):
                completion(.failure(error))
                
            }
        }
        
    }
    
}



