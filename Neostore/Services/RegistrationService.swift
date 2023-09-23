
//  RegisterApiService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit

class RegisterWebService {
    func RegisterAction(Fname: String , Lname: String, Email: String, Pass: String, Cpass: String, Gender: String, Phone: String, chkBox: Bool , Completion : @escaping (Result<(User?,UserResponseFalied?),Error>)->Void)
    {
        let param = ["first_name":Fname , "last_name":Lname , "email":Email ,"password":Pass,"confirm_password":Cpass ,"gender":Gender,"phone_no":Phone]
        APIManager.shared.callRequest(apiCallType: .userRegister(param:param )){
            (responce) in
            switch responce {
            case .success(let data):
                do {
                    let registerSuccess = try JSONDecoder().decode(User.self, from: data)
                    Completion(.success((registerSuccess, nil)))
                }catch{
                    do {
                        let userResponseFalied = try JSONDecoder().decode(UserResponseFalied.self, from: data)
                        Completion(.success((nil,userResponseFalied)))
                    } catch {
                        Completion(.failure(error))
                    }
                }
            case .failure(let error ):
                Completion(.failure(error))
            }
        }
    }
}
