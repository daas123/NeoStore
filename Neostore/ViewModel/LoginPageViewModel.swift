//
//  LoginPageViewModel.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import Foundation

class loginViewModel{
    let loginservice = LoginWebService()
    
    func loginValidation(email : String , password : String, complition :@escaping (String)-> Void){
        validation().loginValidation(email: email, password: password){
            (resultMsg) in
            if resultMsg == txtfieldValConst.emptyStr{
                self.loginservice.loginAction(email: email, password: password){
                    (responce) in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            UserDefaults.standard.set(value.0?.data?.access_token, forKey: userDefConstant.accessToken)
                            complition(txtfieldValConst.emptyStr)
                        }else if value.1 != nil{
                            complition(txtfieldValConst.emptyStr)
                        }else{
                            complition((value.2?.user_msg)!)
                        }
                    case .failure(let error):
                        complition(error.localizedDescription)
                    }
                }
            }else{
                complition(resultMsg)
            }
        }
    }
    
    func chnagePassword(old_password:String,password:String,confirm_password:String,complition :@escaping (String)-> Void){
        validation().changeAction(old_password: old_password, password: password, confirm_password: confirm_password){
            (resultMsg) in
            if resultMsg == txtfieldValConst.emptyStr{
                self.loginservice.changeAction(old_password: old_password, password: password, confirm_password: confirm_password){
                    responce in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            complition(txtfieldValConst.emptyStr)
                        }else{
                            complition(value.1?.user_msg ?? errorConstant.error)
                        }
                    case .failure(let error):
                        complition (error.localizedDescription)
                    }
                }
            }else{
                complition(resultMsg)
            }
        }
        
    }
    func forgetPassword(email:String,complition :@escaping (String)-> Void){
        validation().resetValidation(email: email){
            (resultMsg) in
            if resultMsg == txtfieldValConst.emptyStr{
                self.loginservice.forgetAction(email: email){
                    responce in
                    switch responce{
                    case .success(let value):
                        if value.0 != nil{
                            complition(txtfieldValConst.emptyStr)
                        }else{
                            complition(value.1?.user_msg ?? txtfieldValConst.someThingWentWrong)
                        }
                    case .failure(let error):
                        complition (error.localizedDescription)
                    }
                }
            }else
            {
                complition(resultMsg)
            }
        }
        
    }
    
}




