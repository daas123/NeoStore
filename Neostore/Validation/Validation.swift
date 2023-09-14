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
    
    func registerValidation(Fname: String?, Lname: String?, Email: String?, Pass: String?, Cpass: String?, Gender: String?, Phone: String?, chkBox: Bool?, completion: @escaping (Bool, String) -> Void) {
        
        // Optional unwrapping and trimming whitespace
        guard let firstName = Fname?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty, firstName.count > 3 else {
            completion(false, "First Name must be at least 4 characters long.")
            return
        }
        
        guard let lastName = Lname?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty, lastName.count > 3 else {
            completion(false, "Last Name must be at least 4 characters long.")
            return
        }
        
        guard let email = Email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            completion(false, "Invalid Email Address.")
            return
        }
        
        guard let password = Pass, password.count >= 8 else {
            completion(false, "Password must be at least 8 characters long.")
            return
        }
        
        guard let confirmPassword = Cpass, confirmPassword == password else {
            completion(false, "Confirm Password does not match Password.")
            return
        }
        
        guard let gender = Gender, !gender.isEmpty , gender != "Nan" else {
            completion(false, "Please select a Gender.")
            return
        }
        
        guard let checkBox = chkBox, checkBox else {
            completion(false, "You must agree to the Terms and Conditions.")
            return
        }
        
        guard let phone = Phone?.trimmingCharacters(in: .whitespaces), !phone.isEmpty, phone.count >= 10, containsOnlyNumbers(phone) else {
            completion(false, "Invalid Mobile Number.")
            return
        }
        
        completion(true, "All fields are valid.")
    }

    // Function to validate email using regular expression
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    // Function to check if a string contains only number

    
    func addToCart(Quantity: String, completion: @escaping (Bool, String) -> Void) {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        // Check if Quantity is a valid integer between 1 and 7
        if let quantityInt = Int(Quantity), (1...7).contains(quantityInt), Quantity.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil {
            completion(true, "All ok")
        } else {
            completion(false, "Quantity must be between 1 to 7 and contain only numbers")
        }
    }
    
    func changeAction(old_password:String,password:String,confirm_password:String,completion: @escaping (Bool, String) -> Void){
        
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
    func addAddressValidation(address :String , landmard:String ,city:String,state:String,zipcode:Int ,country:String, complition :@escaping (Bool, String) -> Void){
        guard address != "" else{
            complition(false,"Enter the address")
            return
        }
        guard landmard != ""  else{
            complition(false,"Enter the landmark")
            return
        }
        guard city != "" else{
            complition(false,"Enter the City")
            return
        }
        guard state != ""  else{
            complition(false,"Enter the State")
            return
        }
        guard country != "" else{
            complition(false,"Enter the Country")
            return
        }
        guard Int(zipcode) != nil else {
            complition(false, "Zipcode should be a number")
            return
        }
        
        
        
        complition(true,"ook")
        
        
    }
}







