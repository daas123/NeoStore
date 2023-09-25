//
//  AccountViewModel.swift
//  Neostore
//
//  Created by Neosoft on 25/09/23.
//

import Foundation
class AccountViewModel{
    func editAccountDetails(first_name: String, last_name: String, email: String, dob: String, phone_no: String,complition : @escaping (Bool,String)->Void){
        
        FetchAccountWEbService().editAccountdata(first_name: first_name, last_name: last_name, email: email, dob: dob, phone_no:phone_no, profile_pic: ""){
            responce in
            switch responce{
            case .success(let data):
                SideMenuViewmodel.menuDemoData = data
                complition(true , "")
            case .failure(let error):
                complition(false,error.localizedDescription )
            }
        }
        
    }
    
    var fname : String = ""
    var lname : String = ""
    var uemail : String = ""
    var udob : String = ""
    var phonenumber : String = ""
    
    func storeData(firstname:String,lastname:String,email:String,dob:String,phoneno:String){
        self.fname = firstname
        self.lname = lastname
        self.uemail = email
        self.udob = dob
        self.phonenumber = phoneno
    }
    
    func chkChanges(firstname:String,lastname:String,email:String,dob:String,phoneno:String)->Bool{
        guard fname == firstname else{
            return false
        }
        guard lname == lastname else{
            return false
        }
        guard uemail == email else{
            return false
        }
        guard udob == dob else{
            return false
        }
        guard phonenumber == phoneno else{
            return false
        }
        return true
    }
}
