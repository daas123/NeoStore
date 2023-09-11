//
//  Validation.swift
//  Neostore
//
//  Created by Neosoft on 23/08/23.
//

import Foundation
import UIKit

class validation{
    func containsOnlyNumbers(_ input: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    func loginValidation(email:String , password:String , complition: @escaping (Bool,String)->Void){
        
        
        guard email != "" else{
            complition(false,"Enter the Username")
            return
        }
        guard password != "" else{
            complition(false,"Enter the Password")
            return
        }
        
        func isValidEmail(_ email: String) -> Bool {
            // Regular expression pattern for a valid email address
            let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            
            // Create a predicate with the emailRegex pattern
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            
            // Evaluate the predicate with the email string
            return emailPredicate.evaluate(with: email)
        }
        
        guard (isValidEmail(email)) else{
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
        
        
        guard ((Email?.contains("@gmail.com")) != nil) else{
            complition (false,"Email InValid")
            return
        }
        
        guard Pass!.count>=8 else{
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
        complition(true,"all OK")
    }
    
    func addToCart(Quantity: String, completion: @escaping (Bool, String) -> Void) {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        // Check if Quantity is a valid integer between 1 and 7
        if let quantityInt = Int(Quantity), (1...7).contains(quantityInt), Quantity.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil {
            completion(true, "All ok")
        } else {
            completion(false, "Quantity must be between 1 to 7 and contain only numbers")
        }
    }
    
    func forgetPass(old_password:String,password:String,confirm_password:String,completion: @escaping (Bool, String) -> Void){
        
        guard password != "" && old_password != "" && confirm_password != "" else{
            completion(false,"all Text Filled must be Filled")
            return
        }
        
        guard password == confirm_password else{
            completion(false,"Both NewPassword Must Be Same")
            return
        }
        guard password.count <= 8 || confirm_password.count <= 8 || old_password.count <= 8 else{
            completion(false,"password must be less than 8 character")
            return
        }
        
        completion(true,"All Ok")
    }
}







