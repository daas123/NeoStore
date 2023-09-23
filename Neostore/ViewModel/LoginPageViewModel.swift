//
//  LoginPageViewModel.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class loginViewModel{
    let loginservice = LoginWebService()
    
    func loginValidation(email : String , password : String, complition :@escaping (Bool, String)-> Void){
        validation().loginValidation(email: email, password: password){
            (ValidBool,ErrorString) in
            if ValidBool{
                self.loginservice.loginAction(email: email, password: password){
                    (responce) in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            UserDefaults.standard.set(value.0?.data?.access_token, forKey: userDefConstant.accessToken)
                            complition(true,(value.0?.user_msg)!)
                        }else if value.1 != nil{
                            complition(false,(value.1?.userMsg)!)
                        }else{
                            complition(false,(value.2?.user_msg)!)
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
    
    func chnagePassword(old_password:String,password:String,confirm_password:String,complition :@escaping (Bool, String)-> Void){
        validation().changeAction(old_password: old_password, password: password, confirm_password: confirm_password){
            (ValidBool,ErrorString) in
            if ValidBool{
                self.loginservice.changeAction(old_password: old_password, password: password, confirm_password: confirm_password){
                    responce in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            complition(true,value.0?.user_msg ?? "Done")
                        }else{
                            complition(false,value.1?.user_msg ?? "Error")
                        }
                    case .failure(let error):
                        complition (false , errorConstant.error)
                    }
                }
            }else{
                complition(false,errorConstant.error)
            }
        }
        
    }
    func forgetPassword(email:String,complition :@escaping (Bool, String)-> Void){
        validation().resetValidation(email: email){
            (ValidBool,ErrorString) in
            if ValidBool{
                self.loginservice.forgetAction(email: email){
                    responce in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            complition(true,value.0?.user_msg ?? "done")
                        }else{
                            complition(false,value.1?.user_msg ?? "error")
                        }
                    case .failure(let error):
                        complition (false , error.localizedDescription)
                    }
                }
            }else
            {
                complition(false,ErrorString)
            }
        }
        
    }
    
}




