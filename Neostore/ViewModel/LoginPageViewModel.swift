//
//  LoginPageViewModel.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class loginViewModel{
    let loginservice = LoginWebService()
    
    func loginValidation(email : String , password : String, complition :  @escaping (Bool, String)-> Void){
        validation().loginValidation(email: email, password: password){
            (ValidBool,ErrorString) in
            if ValidBool{
                self.loginservice.loginAction(email: email, password: password){
                    (responce) in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            UserDefaults.standard.set(value.0?.data?.access_token, forKey: "accessToken")
                            complition(true,(value.0?.user_msg)!)
                        }else{
                            complition(false,(value.1?.userMsg)!)
                        }
                    case .failure(let error):
                        complition (false , error.localizedDescription)
                    }
                }
            }else{
                complition(false,ErrorString)
            }
        }
    }
    
}

