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
        
        
        guard email != validationConstant.emptyStr else{
            complition(false,validationConstant.enterTheUsername)
            return
        }
        guard password != validationConstant.emptyStr else{
            complition(false,validationConstant.enterThePassword)
            return
        }
        
        func isValidEmail(_ email: String) -> Bool {
            let emailRegex = validationConstant.emailAllowedChar
            let emailPredicate = NSPredicate(format: validationConstant.emailStruct, emailRegex)
            return emailPredicate.evaluate(with: email)
        }
        guard (isValidEmail(email)) else{
            complition(false,validationConstant.enterTheValidEmail)
            return
        }
        complition(true,validationConstant.ook)
        
        
        
    }
    
    func registerValidation(Fname: String?, Lname: String?, Email: String?, Pass: String?, Cpass: String?, Gender: String?, Phone: String?, chkBox: Bool?, completion: @escaping (Bool, String) -> Void) {
        
        // Optional unwrapping and trimming whitespace
        guard let firstName = Fname?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty, firstName.count > 3 else {
            completion(false, validationConstant.firstNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let lastName = Lname?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty, lastName.count > 3 else {
            completion(false, validationConstant.lastNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let email = Email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            completion(false, validationConstant.invalidEmailAddress)
            return
        }
        
        guard let password = Pass, password.count >= 8 else {
            completion(false, validationConstant.passwordMustBeAtLeastCharactersLong)
            return
        }
        
        guard let confirmPassword = Cpass, confirmPassword == password else {
            completion(false, validationConstant.confirmPasswordDoesNotMatchPassword)
            return
        }
        
        guard let gender = Gender, !gender.isEmpty , gender != "NaN" else {
            completion(false, validationConstant.pleaseSelectaGender)
            return
        }
        guard let phone = Phone?.trimmingCharacters(in: .whitespaces), !phone.isEmpty, phone.count >= 10, containsOnlyNumbers(phone) else {
            completion(false, validationConstant.invalidMobileNumber)
            return
        }
        
        guard let checkBox = chkBox, checkBox else {
            completion(false, validationConstant.agreeTermsAndCondition)
            return
        }
        
        guard let phone = Phone?.trimmingCharacters(in: .whitespaces), !phone.isEmpty, phone.count >= 10, containsOnlyNumbers(phone) else {
            completion(false, validationConstant.invalidMobileNumber)
            return
        }
        if let phone = Phone , phone.count > 10 {
            completion(false, validationConstant.invalidMobileNumber)
        }else{
            completion(true, validationConstant.ook)
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = validationConstant.emailAllowedChar
        return NSPredicate(format: validationConstant.emailStruct, emailRegex).evaluate(with: email)
    }
    
    func addToCart(Quantity: String, completion: @escaping (Bool, String) -> Void) {
        let allowedCharacterSet = CharacterSet(charactersIn: validationConstant.numberAllowed)
        if let quantityInt = Int(Quantity), (1...7).contains(quantityInt), Quantity.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil {
            completion(true, validationConstant.ook)
        } else {
            completion(false, validationConstant.quantityMustBeBetweenAndContainOnlyNumbers)
        }
    }
    
    func changeAction(old_password:String,password:String,confirm_password:String,completion: @escaping (Bool, String) -> Void){
        
        guard password != validationConstant.emptyStr && old_password != validationConstant.emptyStr && confirm_password != validationConstant.emptyStr else{
            completion(false,validationConstant.allTextFilledMustBeFilled)
            return
        }
        
        guard password == confirm_password else{
            completion(false,validationConstant.confirmPasswordDoesNotMatchPassword)
            return
        }
        guard password.count <= 8 || confirm_password.count <= 8 || old_password.count <= 8 else{
            completion(false,validationConstant.passwordMustBeAtLeastCharactersLong)
            return
        }
        
        completion(true,validationConstant.ook)
    }
    func addAddressValidation(address :String , landmard:String ,city:String,state:String,zipcode:Int ,country:String, complition :@escaping (Bool, String) -> Void){
        guard address != validationConstant.emptyStr else{
            complition(false,validationConstant.allTextFilledMustBeFilled)
            return
        }
        guard landmard != validationConstant.emptyStr  else{
            complition(false,validationConstant.enterTheLandmark)
            return
        }
        guard city != validationConstant.emptyStr else{
            complition(false,validationConstant.enterTheCity)
            return
        }
        guard state != validationConstant.emptyStr  else{
            complition(false,validationConstant.enterTheState)
            return
        }
        guard country != validationConstant.emptyStr else{
            complition(false,validationConstant.enterTheCountry)
            return
        }
        guard Int(zipcode) != nil else {
            complition(false, validationConstant.zipcodeShouldBeNumber)
            return
        }
        complition(true,validationConstant.ook)
        
        
    }
}







