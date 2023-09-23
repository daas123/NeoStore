//
//  RegisterViewModel.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit


class RegisterViewModel: NSObject {
    let registerservice = RegisterWebService()
    func registervalidation(Fname:String , Lname:String ,Email:String,Pass :String,Cpass:String ,Gender:String,Phone:String, chkBox:Bool , complition : @escaping (Bool,String)->Void)
    {
        validation().registerValidation(Fname: Fname, Lname: Lname, Email: Email, Pass: Pass, Cpass: Cpass, Gender: Gender, Phone: Phone, chkBox: chkBox){
            (BoolVlaue , resultString) in
            if BoolVlaue{
                self.registerservice.RegisterAction(Fname: Fname, Lname: Lname, Email: Email, Pass: Pass, Cpass: Cpass, Gender: Gender, Phone: Phone, chkBox: chkBox){
                    (responce) in
                    switch responce{
                    case .success(let data):
                        if data.0 != nil{
                            complition(true,data.0?.user_msg ?? "done")
                        }else if data.1 != nil{
                            complition(true,data.1?.userMsg ?? "faliuer")
                        }
                    case .failure(let error):
                        complition(false,error.localizedDescription)
                    }
                }
            }else{
                complition(BoolVlaue,resultString)
            }
        }
    }
}
