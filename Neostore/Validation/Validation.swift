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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = validationConstant.emailAllowedChar
        let emailPredicate = NSPredicate(format: validationConstant.emailStruct, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func loginValidation(email:String? , password:String , complition: @escaping (String)->Void){
        
        guard email != validationConstant.emptyStr else{
            complition(validationConstant.enterTheUsername)
            return
        }
        guard password != validationConstant.emptyStr else{
            complition(validationConstant.enterThePassword)
            return
        }
        guard let email = email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            complition(validationConstant.invalidEmailAddress)
            return
        }
        
        guard (isValidEmail(email)) else{
            complition(validationConstant.enterTheValidEmail)
            return
        }
        complition(validationConstant.emptyStr)
        
        
        
    }
    
    func registerValidation(Fname: String?, Lname: String?, Email: String?, Pass: String?, Cpass: String?, Gender: String?, Phone: String?, chkBox: Bool?, completion: @escaping (String) -> Void) {
        
        // Optional unwrapping and trimming whitespace
        guard let firstName = Fname?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty, firstName.count > 3 else {
            completion(validationConstant.firstNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let lastName = Lname?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty, lastName.count > 3 else {
            completion(validationConstant.lastNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let email = Email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            completion(validationConstant.invalidEmailAddress)
            return
        }
        
        guard let password = Pass, password.count >= 8 else {
            completion(validationConstant.passwordMustBeAtLeastCharactersLong)
            return
        }
        
        guard let confirmPassword = Cpass, confirmPassword == password else {
            completion( validationConstant.confirmPasswordDoesNotMatchPassword)
            return
        }
        
        guard let gender = Gender, !gender.isEmpty , gender != "NaN" else {
            completion(validationConstant.pleaseSelectaGender)
            return
        }
        guard let phone = Phone?.trimmingCharacters(in: .whitespaces), !phone.isEmpty, phone.count >= 10, containsOnlyNumbers(phone) else {
            completion(validationConstant.invalidMobileNumber)
            return
        }
        
        guard let checkBox = chkBox, checkBox else {
            completion( validationConstant.agreeTermsAndCondition)
            return
        }
        
        if let phone = Phone , phone.count > 10 {
            completion(validationConstant.phoneNoMustBeEqualTo)
        }else{
            completion(validationConstant.emptyStr)
        }
    }
    
    func addToCart(Quantity: String, completion: @escaping (String) -> Void) {
        let allowedCharacterSet = CharacterSet(charactersIn: validationConstant.numberAllowed)
        if let quantityInt = Int(Quantity), (1...7).contains(quantityInt), Quantity.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil {
            completion(validationConstant.emptyStr)
        } else {
            completion(validationConstant.quantityMustBeBetweenAndContainOnlyNumbers)
        }
    }
    
    func changeAction(old_password: String, password: String, confirm_password: String, completion: @escaping (String) -> Void) {
        
        guard !old_password.isEmpty && !password.isEmpty && !confirm_password.isEmpty else {
            completion(validationConstant.allTextFilledMustBeFilled)
            return
        }
        
        guard password == confirm_password else {
            completion(validationConstant.confirmPasswordDoesNotMatchPassword)
            return
        }
        
        guard password.count > 8 && confirm_password.count > 8 && old_password.count > 8 else {
            completion(validationConstant.passwordMustBeAtLeastCharactersLong)
            return
        }
        
        completion(validationConstant.emptyStr)
    }
    
    func addAddressValidation(address :String , landmard:String ,city:String,state:String,zipcode:Int ,country:String, complition :@escaping (String) -> Void){
        guard address != validationConstant.emptyStr else{
            complition(validationConstant.allTextFilledMustBeFilled)
            return
        }
        guard landmard != validationConstant.emptyStr  else{
            complition(validationConstant.enterTheLandmark)
            return
        }
        guard city != validationConstant.emptyStr else{
            complition(validationConstant.enterTheCity)
            return
        }
        guard state != validationConstant.emptyStr  else{
            complition(validationConstant.enterTheState)
            return
        }
        guard country != validationConstant.emptyStr else{
            complition(validationConstant.enterTheCountry)
            return
        }
        guard Int(zipcode) != nil else {
            complition( validationConstant.zipcodeShouldBeNumber)
            return
        }
        complition(validationConstant.emptyStr)
    }
    
    func resetValidation(email:String? ,complition :@escaping (String) -> Void){
        guard email != validationConstant.emptyStr else{
            complition(validationConstant.enterTheUsername)
            return
        }
        
        guard let email = email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            complition(validationConstant.invalidEmailAddress)
            return
        }
        complition(validationConstant.emptyStr)
    }

    
    func editAccountValidation(fname: String?, lname: String?, email: String?, phone: String?, dob: String?, completion: @escaping (String) -> Void) {
        guard let firstName = fname?.trimmingCharacters(in: .whitespaces), !firstName.isEmpty, firstName.count > 3 else {
            completion(validationConstant.firstNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let lastName = lname?.trimmingCharacters(in: .whitespaces), !lastName.isEmpty, lastName.count > 3 else {
            completion(validationConstant.lastNameMustBeAtLeastCharactersLong)
            return
        }
        
        guard let email = email?.trimmingCharacters(in: .whitespaces), !email.isEmpty, isValidEmail(email) else {
            completion(validationConstant.invalidEmailAddress)
            return
        }
        
        guard let phone = phone?.trimmingCharacters(in: .whitespaces), !phone.isEmpty, phone.count >= 10, containsOnlyNumbers(phone) else {
            completion(validationConstant.invalidMobileNumber)
            return
        }
        
        guard let dob = dob, let dateOfBirth = dateFromString(dob) else {
            completion(validationConstant.doberror)
            return
        }
        
        let currentDate = Date()
        
        if dateOfBirth > currentDate {
            completion(validationConstant.doberror)
        } else {
            completion(validationConstant.emptyStr)
        }
    }
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateString)
    }
    
}





