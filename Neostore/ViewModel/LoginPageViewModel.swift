//
//  LoginPageViewModel.swift
//  Neostore
//
//  Created by Neosoft on 22/08/23.
//

import Foundation
protocol loginviewDeligate: NSObject{
    func showAlert(msg:String)
}

class loginViewModel{
    let loginservice = loginApiService()
    weak var logindeligate: loginviewDeligate?
    func callValidations(username: String , password : String){
        func validate() -> Bool{
            if username == "" {
                logindeligate?.showAlert(msg: "username ecannot be empty")
                return false
            }
            if password == "" {
                logindeligate?.showAlert(msg: "password cannot be empty")
                return false
            }
            return true
        }
        if validate(){
            loginservice.LoginUser(Username: username, pass: password){
                (response) in
                switch response {
                case .success(let value):
                    print(value)
                    DispatchQueue.main.async {
                        if value.status == 200{
                            self.logindeligate?.showAlert(msg: "login Successfull")
                        }
                        else{
                            self.logindeligate?.showAlert(msg: value.user_msg!)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.logindeligate?.showAlert(msg: String(error.localizedDescription))
                    }
                }
            }
        }
    }
    
}

