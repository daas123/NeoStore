//
//  Validation.swift
//  Neostore
//
//  Created by Neosoft on 23/08/23.
//

import Foundation
import UIKit

class validation{
    func loginValidation(email:String , password:String , complition: @escaping (Bool,String)->Void){
        
        
        guard email != "" else{
            complition(false,"Enter the Username")
            return
        }
        guard password != "" else{
            complition(false,"Enter the Password")
            return
        }
        
        guard email.contains("@") else{
            complition(false,"enter the valid email")
            return
        }
        complition(true,"All Fields Are ook")
        
    }
    
    func registerValidation(Fname:String? , Lname:String? ,Email:String?,Pass :String?,Cpass:String? ,Gender:String?,Phone:String?, chkBox:Bool?, complition: @escaping (Bool,String)->Void ){
        
        guard Fname!.count>3  else{
            complition (false,"FirstName Must Greater Then 3 Chracter")
            return
        }
        
        
        guard Lname!.count>3 else{
            complition (false,"LastName Must Greater Then 3 Chracter")
            return
        }
        
        
        guard Email!.contains("@") && Email!.contains(".") else{
            complition (false,"Email InValid")
            return
        }
        
        guard Pass!.count>8 else{
            complition (false,"Password Must cotain: 8 character")
            return
        }
        
        guard Cpass == Pass else{
            complition (false,"Comform Password is Not Same")
            return
        }
        
        guard Gender == "M" else{
            complition (false,"Enter the Gender")
            return
        }
        guard chkBox == true else{
            complition(false,"Agree Terms and Condition")
            return
        }
        
        guard Phone!.count>10 || containsOnlyNumbers(Phone!) else{
            complition (false,"Enter valid Mobile NO")
            return
        }
        func containsOnlyNumbers(_ input: String) -> Bool {
            let numericCharacterSet = CharacterSet.decimalDigits
            let inputCharacterSet = CharacterSet(charactersIn: input)
            return numericCharacterSet.isSuperset(of: inputCharacterSet)
        }
        
        complition(true,"all OK")
    }
}







